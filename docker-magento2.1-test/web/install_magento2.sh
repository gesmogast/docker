#!/bin/bash
# Installation Magento2 web site on prepared container with nginx and php7-fpm
echo "Installing Magento2"
/var/www/magento/bin/magento setup:install --backend-frontname="admin" \
--key="biY8vdWx4w8KV5Q59380Fejy36l6ssUb" \
--db-host="db" \
--db-name="magentodb" \
--db-user="magento" \
--db-password="septimo" \
--language="en_US" \
--currency="USD" \
--timezone="America/New_York" \
--use-rewrites=1 \
--use-secure=0 \
--base-url="http://"$1 \
--admin-user=admin \
--admin-password=ABCdefg123! \
--admin-email=admin@$1 \
--admin-firstname=admin \
--admin-lastname=user \
--cleanup-database
echo "Configuring website permissions"
chmod 700 /var/www/magento/app/etc
chown -R www-data:www-data /var/www/magento
echo "Restarting nginx"
service nginx restart
