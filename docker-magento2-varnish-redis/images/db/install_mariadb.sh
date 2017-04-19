#!/bin/bash
# This script installs Magento2 on the Ubuntu 14.04
dbpass='septimo'
echo "Adding Percona repository"
apt-get install software-properties-common -y
wget https://repo.percona.com/apt/percona-release_0.1-4.$(lsb_release -sc)_all.deb
# Install percona repository
dpkg -i percona-release_0.1-4.$(lsb_release -sc)_all.deb
# Update apt cache
apt-get update
echo "Installing Percona 5.6"
#export DEBIAN_FRONTEND="noninteractive"
echo percona-server-server-5.6 percona-server-server/root_password password $dbpass | debconf-set-selections
echo percona-server-server-5.6 percona-server-server/root_password_again password $dbpass | debconf-set-selections

# Install Percona-server 5.6
apt-get install percona-server-server-5.6 -y

echo "Changing my.cnf to listen 0.0.0.0:3306"
sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
