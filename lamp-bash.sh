#!/bin/bash

#check wether run as root or not
if [[ $EUID -ne 0 ]]; then
   printf "Error Please run this script as root!\n"
   exit 1
fi

echo -e "\nUpdating Apt Packages and upgrading latest patches in debian\n"
apt-get update -y && sudo apt-get upgrade -y

echo -e "\nInstalling Apache2 Web server on system\n"
apt install apache2 -y
systemctl start apache2
systemctl enable apache2
systemctl status apache2 --no-pager

echo -e "\n\nInstalling PHP\n"
apt install php php-mysql php-gd php-cli php-common -y

echo -e "\n\nInstalling Databse Software\n"
echo -e "\nWhich Database do you want to install?\n"
read -p "Enter mysql or mariadb [mysql,mariadb] :" database
case $database in
  mysql|MYSQL)
          echo -e "\n\nInstalling MySQL\n";
          apt install mysql-server mysql-client -y;
          systemctl start mysql;
          systemctl enable mysql;
          systemctl status mysql --no-pager;;
  mariadb|MARIADB)
          echo -e "\n\nInstalling MariaDB\n";
          apt install mariadb-server mariadb-client -y;
          systemctl start mariadb;
          systemctl enable mariadb;
          sudo systemctl status mariadb --no-pager;;
  *) echo \n user input error please enter mysql or mariadb\n  ;;
esac

echo -e "\n\nChange Permissions for /var/www\n"
ls -l /var/www
chown -R www-data:www-data /var/www
ls -l /var/www

echo -e "\n\nLAMP Stack Installation Completed"

exit 0;