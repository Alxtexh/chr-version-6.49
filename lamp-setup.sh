#!/bin/bash
set -e

# 💠 ALX Banner
clear
echo -e "\e[96m"
echo " █████╗ ██╗      ██╗  ██╗"
echo "██╔══██╗██║      ╚██╗██╔╝"
echo "███████║██║█████╗ ╚███╔╝ "
echo "██╔══██║██║╚════╝ ██╔██╗ "
echo "██║  ██║███████╗ ██╔╝ ██╗"
echo "╚═╝  ╚═╝╚══════╝ ╚═╝  ╚═╝"
echo "        A   L   X        "
echo -e "\e[0m"

sleep 1
echo "🌀 Welcome Alxtexh scripts "
echo "🌀 Updating system..."
sudo apt update && sudo apt upgrade -y

echo "📦 Installing Apache..."
sudo apt install apache2 -y
sudo ufw allow 'Apache Full'
sudo ufw allow 22/tcp
sudo ufw enable

echo "🚀 Starting Apache..."
sudo systemctl enable apache2
sudo systemctl start apache2

echo "🐬 Installing MySQL..."
sudo apt install mysql-server -y
sudo mysql_secure_installation <<< $'\n0\nY\nY\nY\nY\n'

echo "🎯 Creating MySQL user..."
read -p "Enter MySQL username: " mysql_user
read -s -p "Enter MySQL password: " mysql_pass
echo ""
sudo mysql <<EOF
CREATE USER '${mysql_user}'@'localhost' IDENTIFIED BY '${mysql_pass}';
GRANT ALL PRIVILEGES ON *.* TO '${mysql_user}'@'localhost';
FLUSH PRIVILEGES;
EXIT;
EOF

echo "💻 Installing PHP 8.2..."
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update
sudo apt install php8.2-fpm php8.2 libapache2-mod-php8.2 php8.2-common php8.2-mysql php8.2-xml php8.2-xmlrpc php8.2-curl php8.2-gd php8.2-imagick php8.2-cli php8.2-imap php8.2-mbstring php8.2-opcache php8.2-soap php8.2-zip php8.2-intl php8.2-bcmath unzip -y

echo "⚙️ Configuring PHP..."
sudo sed -i 's/^upload_max_filesize = .*/upload_max_filesize = 32M/' /etc/php/8.2/apache2/php.ini
sudo sed -i 's/^post_max_size = .*/post_max_size = 48M/' /etc/php/8.2/apache2/php.ini
sudo sed -i 's/^memory_limit = .*/memory_limit = 256M/' /etc/php/8.2/apache2/php.ini
sudo sed -i 's/^max_execution_time = .*/max_execution_time = 600/' /etc/php/8.2/apache2/php.ini
sudo sed -i 's/^max_input_vars = .*/max_input_vars = 3000/' /etc/php/8.2/apache2/php.ini
sudo sed -i 's/^max_input_time = .*/max_input_time = 1000/' /etc/php/8.2/apache2/php.ini
sudo systemctl restart apache2

echo "📘 Installing phpMyAdmin..."
sudo apt install phpmyadmin -y
sudo a2enconf phpmyadmin
sudo systemctl restart apache2

echo "📆 Adding cron job..."
(crontab -l ; echo "*/5 * * * * /usr/bin/php /var/www/html/cron.php") | sort -u | crontab -

echo "📦 Installing Composer..."
sudo apt install composer -y

echo "🔁 Enabling Apache rewrite module..."
sudo apt install libapache2-mod-rewrite -y
sudo a2enmod rewrite
sudo service apache2 restart

echo "🌐 Setup complete."
echo "Regards - Alxtexh"