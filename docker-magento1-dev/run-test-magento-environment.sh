#!/bin/bash
# Run docker-compose up
docker-compose up -d
# Do post-installation tasks
echo "Wait 5 seconds to compleately start containers"
sleep 5s
containername=$(docker ps --filter "name=magento_1" | awk '{if(NR>1) print $NF}')
echo "Configuring site name"
# Site name = script's first argument, otherwise it is testmagento.org
sitename=${1:-testmagento.org}
# Make soft-link
docker exec $containername ln -s /etc/nginx/sites-available/magento.conf /etc/nginx/sites-enabled/magento.conf
# Check if sitename is configured
if [[ "$sitename" != "testmagento.org" ]]
then
    echo "Replacing default nginx testmagento.org server configuration with $sitename"
    # Using sed to replace nginx default configured server name
    docker exec $containername sed -i 's/testmagento.org/$sitename/g' /etc/nginx/sites-available/magento.conf
fi
# Reloading nginx
docker exec $containername /etc/init.d/nginx reload
