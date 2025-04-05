#!/bin/bash
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
else
    echo ".env file not found!"
    exit 1
fi

if [ -z "$WORDPRESS_DB_HOST" ] || [ -z "$WORDPRESS_DB_USER" ] || [ -z "$WORDPRESS_DB_PASSWORD" ] || [ -z "$WORDPRESS_DB_NAME" ]; then
    exit 1
fi

terraform init
terraform apply -auto-approve

INSTANCE_IP=$(terraform output -raw instance_public_ip)
RDS_ENDPOINT=$(terraform output -raw rds_endpoint)

while ! ssh -o ConnectTimeout=5 -o StrictHostKeyChecking=no -i /home/harshal/Downloads/my-key.pem ubuntu@$INSTANCE_IP exit; do   
  sleep 5
done

export RDS_HOST=$RDS_ENDPOINT

ansible-playbook -i ansible/inventory.ini ansible/docker_deployment.yml

ssh -o StrictHostKeyChecking=no -i /home/harshal/Downloads/my-key.pem ubuntu@$INSTANCE_IP <<EOF
  sudo apt update && sudo apt install -y mysql-client

  until mysql -h "$WORDPRESS_DB_HOST" -u "$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" -e "SELECT 1;" &> /dev/null; do
    sleep 5
  done

  mysql -h "$WORDPRESS_DB_HOST" -u "$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" -e "
    CREATE DATABASE IF NOT EXISTS $WORDPRESS_DB_NAME;
    GRANT ALL PRIVILEGES ON $WORDPRESS_DB_NAME.* TO '$WORDPRESS_DB_USER'@'%';
    FLUSH PRIVILEGES;"

  docker run -d --name wordpress -p 80:80 \
    -e WORDPRESS_DB_HOST="$WORDPRESS_DB_HOST" \
    -e WORDPRESS_DB_USER="$WORDPRESS_DB_USER" \
    -e WORDPRESS_DB_PASSWORD="$WORDPRESS_DB_PASSWORD" \
    -e WORDPRESS_DB_NAME="$WORDPRESS_DB_NAME" \
    wordpress:latest

  sleep 10

  docker exec wordpress bash -c "
    apt update && apt install -y wget less &&
    wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar &&
    chmod +x /usr/local/bin/wp"
  
  echo "Checking if WordPress is already installed..."
  if sudo docker exec wordpress bash -c "wp core is-installed --path='/var/www/html' --allow-root"; then
    echo "WordPress is already installed!"
  else
    echo "Running WordPress installation..."
    sudo docker exec wordpress bash -c "
      wp core install \
      --url='https://harshal.purvesh.cloud' \
      --title='$WORDPRESS_SITE_TITLE' \
      --admin_user='$WORDPRESS_ADMIN_USER' \
      --admin_password='$WORDPRESS_ADMIN_PASSWORD' \
      --admin_email='$WORDPRESS_ADMIN_EMAIL' \
      --path='/var/www/html' \
      --allow-root"

    sudo docker exec wordpress bash -c "wp option update siteurl 'https://harshal.purvesh.cloud' --allow-root"
    sudo docker exec wordpress bash -c "wp option update home 'https://harshal.purvesh.cloud' --allow-root"

    echo "WordPress setup complete!"
  fi
EOF

echo "Deployment completed successfully!"
