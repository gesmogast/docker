#!/bin/bash
# Run docker-compose up
docker-compose up -d
# Do post-installation tasks (install magento2 and copy env.php to add redis configuration to magento instance)
echo "Waiting 5 seconds to start containers fully"
sleep 5s
# Figure out container name
containername=$(docker ps --filter "name=magento_1" | awk '{if(NR>1) print $NF}')
# Do post-installation tasks (install magento2)
# Check if there is no website in the webroot
DIR="./project/website"
if [ "$(ls -A $DIR)" ]; then
     echo "Website is in project/website folder"
else
    echo "No website in project/website folder. Downloading default magento2"
    cd ./project/website/
    wget https://github.com/magento/magento2/archive/2.1.3.tar.gz
    tar xzf 2.1.3.tar.gz
    rm -rf 2.1.3.tar.gz
    mv magento2-2.1.3/ magento
fi
#cd ../..
#DIR2="./project/nginxconf"
#if [ "$(ls -A $DIR2)" ]; then
#     echo "Nginx configuration is in project/nginxconf folder"
#else
#    echo "No website in project/nginxconf folder. Copying default template"
#    cp ./web/magento.conf ./project/website/
#fi
# Site name = script's first argument, otherwise it is testmagento.org
sitename=${1:-testmagento.org}
# copy nginx config
docker cp web/magento.conf $containername:/etc/nginx/sites-available/
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
