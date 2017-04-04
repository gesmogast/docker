#!/bin/bash
# Run docker-compose up
docker-compose up -d
# Do post-installation tasks (install magento2 and copy env.php to add redis configuration to magento instance)
echo "Waiting 10 seconds to start containers fully"
sleep 10s
# Figure out container name
containername=$(docker ps --filter "name=magento_1" | awk '{if(NR>1) print $NF}')
# Do post-installation tasks (install magento2)
# Site name = script's first argument, otherwise it is testmagento.org
sitename=${1:-testmagento.org}
# Going to conf directory, where magento installation script is located
cd conf/
# Copy installation script inside web docker container
docker cp install_and_configure_magento2.sh $containername:/home/
# Make installation script executable
docker exec $containername chmod +x /home/install_and_configure_magento2.sh
# Execute installation script inside a web container
docker exec $containername /bin/sh /home/install_and_configure_magento2.sh $sitename
# Check if sitename is configured
if [[ "$sitename" != "testmagento.org" ]]
then
    echo "Replacing default nginx testmagento.org server configuration with $sitename"
    # Using sed to replace nginx default configured server name
    docker exec $containername sed -i 's/testmagento.org/$sitename/g' /etc/nginx/sites-available/magento.conf
    # Reloading nginx
    docker exec $containername /etc/init.d/nginx reload
fi
