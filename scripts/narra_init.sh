#!/bin/bash
# Narra initialization
rm -rf /home/app/source

if [[ "$PASSENGER_APP_ENV" == "development" ]]; then
    ln -s /narra_source /home/app/source
else
    mkdir /home/app/source
    git clone https://github.com/CAS-FAMU/narra.git /home/app/source/narra
    # Check for tag
    if [ -n "$NARRA_VERSION" ]; then
        git checkout tags/$NARRA_VERSION
    fi
fi

# Narra post initialization
chown -R app:app /home/app/source
cd /home/app/source/narra
sudo -u app bundle install

# Check for debug
if [[ "$DEBUG" == "true" ]]; then
  touch /etc/service/nginx/down
  /usr/sbin/service nginx stop
fi
