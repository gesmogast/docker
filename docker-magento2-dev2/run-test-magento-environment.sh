#!/bin/bash
# Run docker-compose up
docker-compose up -d
# Do post-installation tasks (install magento2 and copy env.php to add redis configuration to magento instance)
sleep 10s
# Figure out container name
containername=$(docker ps --filter "name=magento_1" | awk '{if(NR>1) print $NF}')
# Figure out Nginx site configuration filename
nginxfilename=`ls -A1 /vagrant/project/nginxconf/`
# Create symlink to nginx conf
docker exec $containername /bin/ln -s /etc/nginx/sites-available/$nginxfilename /etc/nginx/sites-enabled/
# reload nginx
docker exec $containername /etc/init.d/nginx reload
# change owner and permissions
echo "Configuring website permissions"
docker exec $containername /bin/chmod 700 /var/www/magento/app/etc
docker exec $containername /bin/chown -R www-data:www-data /var/www/magento

