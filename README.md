# 🛠️ MikroTik CHR 6.49.18 in Docker

This project provides a simple, automated way to run **MikroTik Cloud Hosted Router (CHR) v6.49.18** inside a Docker container using QEMU.

It’s perfect for developers and network engineers looking to test **RouterOS features**, automation scripts, or **API integrations** without spinning up full virtual machines.

---

## 📦 What's Included

- A `chr-6.49.18.img.zip` disk image hosted via GitHub Releases
- A one-click `install-chr.sh` script to:
  - Download and extract CHR image
  - Build a lightweight Docker container
  - Expose commonly used RouterOS ports

---
🔒 Requires Docker and curl installed on your Linux system.
⚙️ Requirements
- Ubuntu VPS or Linux server
- Docker installed (sudo apt install docker.io)
- curl and unzip available

🔐 Login Credentials
- Username: admin
- Password: (leave blank on first login)
- You'll be prompted to set a new password.


## 🚀 Quick Install

```bash
curl -O https://raw.githubusercontent.com/AlxTexh/chr-version-6.49/main/install-chr.sh
chmod +x install-chr.sh
./install-chr.sh
```
🤝 Credits
-Created and maintained by : Alxtexh
-MikroTik CHR © mikrotik.com
