#!/bin/bash
set -e
set -x

# Init permission
chmod +x -R /build/narra/installation
chmod +x -R /build/narra/startup

# Update ubuntu
/build/narra/scripts/ubuntu.sh

# NARRA initialization
/build/narra/scripts/narra_initialize.sh

# Nginx initialization
rm -f /etc/service/nginx/down
rm /etc/nginx/sites-enabled/default
cp /build/narra/nginx/api-narra.conf /etc/nginx/sites-enabled/api-narra.conf
cp /build/narra/nginx/env-narra.conf /etc/nginx/main.d/narra.conf

# Prepare NARRA to update repo while boot
mkdir -p /etc/my_init.d
cp /build/narra/scripts/narra_initialize.sh /etc/my_init.d/01_narra.sh

# Enable the NARRA debug service.
mkdir /etc/service/narra-master-debug
cp /build/narra/scripts/narra_debug.sh /etc/service/narra-master-debug/run
