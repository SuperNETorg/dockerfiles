#!/bin/bash

# Constants
DOMAIN_NAME='jenkins.sprnt.pw'

# Install required packages
sudo apt-get update
sudo apt-get -y install git bc

# Clone letsencrypt to /opt/letsencrypt
echo "Clone letsncrypt installer"
sudo git clone https://github.com/letsencrypt/letsencrypt /opt/letsencrypt

# Install NGINX
echo "Install Nginx"
sudo apt-get install -y nginx 

# Copy Nginx Files
echo "Copy nginx config file from repo to nginx directory"
sudo cp default /etc/nginx/sites-available/

cd /opt/letsencrypt
./letsencrypt-auto certonly -a webroot --webroot-path=/usr/share/nginx/html -d "${DOMAIN_NAME}"

echo "Display generated SSLs"
sudo ls -l /etc/letsencrypt/live/${DOMAIN_NAME} 


echo "Generate Strong Diffie-Hellman Group"
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048 

echo "Reload NGINX configs"
sudo service nginx reload

