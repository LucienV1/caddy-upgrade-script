#!/bin/bash

# Install package repos on apt

sudo apt update #update package list 
sudo apt upgrade -y debian-keyring debian-archive-keyring apt-transport-https # install needed packages to add the custom apt repo

sudo rm -f /usr/share/keyrings/caddy-stable-archive-keyring.gpg # Remove old keyring if exists

curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list

# Update Caddy

sudo apt update
sudo apt upgrade caddy -y

# Add Caddy packages and restart

sudo caddy add-package github.com/caddy-dns/cloudflare
sudo caddy add-package github.com/greenpau/caddy-security
sudo caddy add-package github.com/WeidiDeng/caddy-cloudflare-ip

sudo systemctl restart caddy