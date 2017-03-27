#!/bin/bash
# Run docker-compose up
docker-compose up -d
# Do post-installation tasks (install magento2 and copy env.php to add redis configuration to magento instance)
sleep 10s
echo "Installing magento2"
# Site name = script's first argument, otherwise it is testmagento.org
sitename=${1:-testmagento.org}
# Going to conf directory, where magento installation script is located
cd conf/
# Copy installation script inside web docker container
docker cp install_and_configure_magento2.sh dockermagento2dev_magento_1:/home/
# Make installation script executable
docker exec dockermagento2dev_magento_1 chmod +x /home/install_and_configure_magento2.sh
# Execute installation script inside a web container
docker exec dockermagento2dev_magento_1 /bin/sh /home/install_and_configure_magento2.sh $sitename
# Check if sitename is configured
if [[ "$sitename" != "testmagento.org" ]]
then
    echo "Replacing default nginx testmagento.org server configuration with $sitename"
    # Using sed to replace nginx default configured server name
    docker exec dockermagento2dev_magento_1 sed -i 's/testmagento.org/$sitename/g' /etc/nginx/sites-available/magento.conf
    # Reloading nginx
    docker exec dockermagento2dev_magento_1 /etc/init.d/nginx reload
fi
