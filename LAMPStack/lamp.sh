#!/usr/bin/env bash

apt-get update
apt-get install -y apache2
echo "Apache installed...."
export DEBIAN_FRONTEND="noninteractive"
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
apt-get install -y mysql-server php5-mysql
echo "Mysql installed...."
apt-get install -y php5 libapache2-mod-php5
echo "Php installed...."
/etc/init.d/apache2 restart
echo "LAMP Stack successfully setup...."
if ! [ -L /var/www ]; then
  rm -rf /var/www/html
  ln -fs /vagrant /var/www/html
fi
