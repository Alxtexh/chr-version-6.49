#!/bin/bash

# 📦 Step 1: Download CHR image from GitHub Release
echo "⬇️  Downloading CHR image from GitHub..."
curl -L -o chr.zip https://github.com/AlxTexh/chr-version-6.49/releases/download/v1.0/chr-6.49.18.img.zip

# 📂 Step 2: Extract and prepare the disk image
echo "📦 Unzipping image..."
unzip -o chr.zip
mv chr-6.49.18.img chr.img

# 🛠️ Step 3: Set up Docker workspace
mkdir -p ~/chr6docker && mv chr.img ~/chr6docker/
cd ~/chr6docker

# 📄 Step 4: Create Dockerfile with QEMU and port mappings
cat <<EOF > Dockerfile
FROM ubuntu:20.04

RUN apt update && apt install -y qemu-system-x86

COPY chr.img /chr.img

CMD ["qemu-system-x86_64", "-drive", "file=/chr.img,format=raw", "-nographic", "-net", "nic", "-net", "user,hostfwd=tcp::21-:21,hostfwd=tcp::22-:22,hostfwd=tcp::23-:23,hostfwd=tcp::80-:80,hostfwd=tcp::443-:443,hostfwd=tcp::8291-:8291,hostfwd=tcp::8728-:8728,hostfwd=tcp::8729-:8729"]
EOF

# 🏗️ Step 5: Build the Docker image
echo "🔧 Building Docker image..."
docker build -t chr:v6.49 .

# 🚀 Step 6: Run the container with full port exposure
echo "🚀 Launching CHR container..."
docker run -d --name chr6 --privileged \
  -p 21:21 -p 22:22 -p 23:23 -p 80:80 -p 443:443 \
  -p 8291:8291 -p 8728:8728 -p 8729:8729 \
  chr:v6.49

echo
echo "✅ MikroTik CHR v6.49.18 is now running in Docker."
echo
echo "🌐 To connect:"
echo "   👉 Open Winbox or your browser and use your server IP address directly (e.g.https://your-vps-ip or Winbox IP)."
echo "   🔐 Login: admin  (leave password blank on first login)"
echo
echo "⏳ Please wait about 2 minutes after running this script before logging in — CHR needs a little time to boot inside the container."
echo