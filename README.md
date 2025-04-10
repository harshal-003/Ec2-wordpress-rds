# EC2-RDS-WordPress Deployment 🚀

## 📄 Overview
This project automates the deployment of a WordPress site on an AWS EC2 instance with an RDS MySQL database. The stack includes:

- **Terraform** for infrastructure provisioning
- **Ansible** for server configuration
- **Docker** for WordPress containerization
- **Cloudflare** for DNS management

---

## ✨ Features
- 🖥️ Automated AWS EC2 Instance Creation  
- 💾 AWS RDS MySQL Setup  
- 🔐 Security Group Configuration  
- 🌐 Cloudflare DNS Setup for Custom Domain  
- 📦 WordPress Installation via Docker  
- 🧰 WP-CLI for WordPress Management  

---

## ⚙️ Prerequisites
- AWS Account with IAM Access
- Terraform (`>= 1.2.0`)
- Ansible installed
- Cloudflare Account with API Token & Zone ID
- SSH key for EC2 access

---

## 🚀 Deployment Steps

### 1. Clone the Repository
```bash
git clone https://github.com/joshiharshal/EC2-RDS-Wordpress.git
cd EC2-RDS-Wordpress

```

### 2. Initialize and Apply Terraform
```bash
terraform init
terraform apply -auto-approve
```

### 2. Run Deployment Script
```bash
chmod +x deploy.sh
./deploy.sh
```
This script:
- Retrieves instance and database details
- Creates a `.env` file with database credentials
- Copies `.env` to the instance
- Runs the Ansible playbook
- Deploys WordPress with Docker

### 3. Access WordPress
- Website: [http://harshal.purvesh.cloud](http://ha.purvesrshalh.cloud)
- Admin Panel: [http://harshal.purvesh.cloud/wp-admin](http://harshal.purvesh.cloud/wp-admin)
- Admin Credentials:
  - Username: `admin`
  - Password: `Admin@123`


## Cleanup
To delete all resources:
```bash
terraform destroy -auto-approve
```

## Author
- **Harshal Joshi** - [GitHub](https://github.com/joshiharshal)
