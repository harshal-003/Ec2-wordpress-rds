# EC2-WordPress-RDS 🚀

A fully automated infrastructure setup using **Terraform**, **Ansible**, and **Docker** to deploy a WordPress website on **AWS EC2**, backed by an **RDS MySQL** database. Domain mapping is configured via **Cloudflare**.

---

## 🌐 Project Overview

This project provisions and configures the following:

- ✅ AWS **EC2 Instance** with Docker
- ✅ AWS **RDS MySQL** database
- ✅ **Dockerized WordPress**
- ✅ **Ansible** for automation
- ✅ **Terraform** for infrastructure as code
- ✅ **Cloudflare** for domain pointing (subdomain support)
- ✅ Automatic WordPress installation via **WP-CLI**

---

## ⚙️ Prerequisites

- AWS account with credentials configured
- Cloudflare account with API Token & Zone ID
- Terraform installed (`>= 1.2.0`)
- Ansible installed
- SSH key pair (for EC2 access)
- `.env` file in root directory

---

## 🔐 .env File Example

```env
WORDPRESS_DB_HOST=<RDS Host will be auto-injected>
WORDPRESS_DB_USER=admin
WORDPRESS_DB_PASSWORD=adminpassword
WORDPRESS_DB_NAME=wordpress_db

WORDPRESS_SITE_TITLE=My Awesome Blog
WORDPRESS_ADMIN_USER=admin
WORDPRESS_ADMIN_PASSWORD=admin123
WORDPRESS_ADMIN_EMAIL=admin@example.com

CLOUDFLARE_API_TOKEN=your_cloudflare_api_token
CLOUDFLARE_ZONE_ID=your_cloudflare_zone_id
SUBDOMAIN=harshal
ROOT_DOMAIN= 


## 🚀 Deployment Instructions

```bash
git clone https://github.com/joshiharshal/ec2-wordpress-rds.git
cd ec2-wordpress-rds

cp .env.example .env
# Edit the file with your credentials

chmod +x deploy.sh
./deploy.sh


## 📦 Tools & Technologies

- 🧱 **Terraform** – Infrastructure provisioning  
- 🤖 **Ansible** – Configuration management  
- 🐳 **Docker** – WordPress containerization  
- 💾 **AWS RDS** – MySQL managed service  
- ☁️ **AWS EC2** – Host for WordPress container  
- 🌐 **Cloudflare** – DNS management  

---

## 🌍 Final Output

After a successful deployment, your WordPress site will be accessible at:

📌 [https://harshal.purvesh.cloud](https://harshal.purvesh.cloud)

✅ **Cloudflare automatically provisions SSL when proxied.**

---

## 🛡️ Security Tips

- Use strong, unique passwords  
- Avoid hardcoding sensitive data. Use environment variables  
- Restrict SSH access by IP in the security group  
- Enable automatic backups for your RDS database  
- Keep your EC2 instance and Docker images up to date  

---

## 📜 License

This project is licensed under the **MIT License**.

---

## 👤 Author

**Harshal Joshi**  
📂 [GitHub Profile](https://github.com/joshiharshal)

---

## 🤝 Contributions

Contributions are welcome!  
Feel free to **fork** the repo, open **issues**, or submit **pull requests**.



