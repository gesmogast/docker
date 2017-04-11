#!/bin/bash
# Run docker-compose up
cd ../
docker-compose up -d
# Do post-installation tasks
echo "Wait 5 seconds to compleately start containers"
sleep 5s
containername=$(docker ps --filter "name=magento_1" | awk '{if(NR>1) print $NF}')
# Site name = script's first argument, otherwise it is testmagento.org
sitename=${1:-testmagento.org}
# Make soft-link
docker exec $containername ln -s /etc/nginx/sites-available/magento.conf /etc/nginx/sites-enabled/magento.conf
# Reloading nginx
docker exec $containername /etc/init.d/nginx reload
# print credentials
echo "Credentials"
echo "-*-*-*-*-"
echo "MySQL access:"
echo "Database: magento"
echo "User: root"
echo "Password: root"
echo "-*-*-*-*-"
echo "SSH access: root"
echo "SSH password: root"
echo "SSH and MySQL ports: docker-compose ps"
echo "-*-*-*-*-"
