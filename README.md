# 🛒 RoboShop - Shell Automation

**Roboshop-shell** is a set of bash scripts designed to automate the deployment and configuration of the "RoboShop" microservices application on Linux servers. It enables consistent, repeatable setups across environments (dev/test/prod).

---

## 🚀 Features

- **Automated installation** of Node.js, Java, and Python microservices
- **System user creation** with isolation per microservice
- **Service setup** with systemd: ensures auto-start, monitoring, and clean shutdown
- **Dependency management**: installs necessary packages (MongoDB, Redis, MySQL, etc.)
- **Idempotent operations**: each script can run multiple times without breaking states
- **Error handling**: fails early with meaningful logs to aid debugging

---

## 🗂️ Repository Structure

```
├── common.sh # Shared variables & utility functions
├── catalog.sh # Installs catalog microservice
├── cart.sh # Installs cart microservice
├── user.sh # Installs user microservice
├── payment.sh # Sets up payment microservice
├── shipping.sh # Deploys shipping microservice
├── frontend.sh # Configures frontend application
├── mysql.sh # MySQL backend setup
├── redis.sh # Redis cache setup
├── mongodb.sh # Mongo database setup
├── systemd-helpers/ # systemd unit file templates
└── logs/ # Execution logs segregated by service
```
---


---

## ⚙️ Prerequisites

Before running the scripts:

- Compatible OS: CentOS 7+/RHEL 9, Amazon Linux 2023.
- SSH or shell access with **sudo** privileges.
- Internet access to fetch dependencies.

---

## 🧩 Usage Guide

### 1. Clone this repository:
```
bash
git clone https://github.com/MannmeetOrg/roboshop-shell.git
cd roboshop-shell
```
---

## 2. Make scripts executable:
```
chmod +x *.sh

---
## 3. Run individual microservice setup:

```
  sudo ./common.sh
  sudo ./catalog.sh
```
# Repeat for cart.sh, user.sh, etc.

---
# Scripts can be run in any order (common.sh recommended first). They detect and skip already-configured components.

---

## 4. Check status:
Verify each component’s service status:
```
  systemctl status catalog
```

# Replace with service name used in script

---

## 🛠️ How It Works

* common.sh: Updates OS, installs user creation, firewall config, logging functions.
* Each microservice script:

    - Creates system user (roboshop or individual)
    
    - Installs dependencies (e.g. Node/npm, Maven, Python)
    
    - Downloads service code or archives
    
    - Builds/installs service
    
    - Configures systemd service from templates
    
    - Starts and enables the service
    
    - Validates health endpoint or log output

* Scripts are idempotent, checking existing installations before proceeding.

---

## 🧪 Running Full Deployment
To streamline setup:

``` 
for svc in common mongodb mysql redis catalog user cart payment shipping frontend; do
sudo ./${svc}.sh || { echo "Deployment failed on $svc"; exit 1; }
done
```

This deploys the entire RoboShop stack in sequence.
---

## 📄 Logging & Troubleshooting

    - Execution logs are written to logs/<service>.log
    
    - Fails fast: scripts exit on error and log descriptive message.
    
    - Check logs and systemd status for when services fail to start.

---
## 🤝 Contributing 👥 Contributing
    Contributions welcome! To help:
    
        - Fork the repo
        - Create a feature branch: git checkout -b my-feature
        - Implement changes or fixes
        - Test locally and update logs/templates accordingly
        - Submit a pull request with clear description

---

📜 License
MIT License – see LICENSE.

---

📋 Summary
This repo automates full-stack deployment of RoboShop using shell scripts and systemd, ensuring fast, 
repeatable environment setup with low overhead—ideal for demo deployments, training, or dev stacks.

---