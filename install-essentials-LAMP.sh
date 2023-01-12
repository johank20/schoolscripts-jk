#!/bin/bash

# Ask for Operating System 
echo "Which Operating System are you using? (Ubuntu, Debian, Centos)"
read os

if [ "$os" = "Ubuntu" ] || [ "$os" = "Debian" ]; then
    #Ask if full-upgrade Requried
    echo "Is this system updatede? (Y/N)"
    read update

if ["$update" = "Y" ]; then
    sudo apt update && sudo apt -y full-upgrade
    #check if reboot nessary
    echo "Reboot machine? (Y/N)"
    read autoreboot
      if [ "$autoreboot" = "Y" ] then
        sudo reboot 
      elif [ "$autoreboot" = "N" ] then
elif [ "$update" = "N" ]


    
    #Add php PPA
    sudo apt update -y
    sudo apt -y install software-properties-common
    sudo add-apt-repository ppa:ondrej/php -y
    sudo apt update -y
    
    # Install Apache
    sudo apt-get install -y apache2
    
    # Ask for MySQL version
    echo "Which version of MySQL do you want to install? (e.g. 'mysql-server-5.7' or mariadb-server)"
    read mysql_version
    
    # Install MySQL
    sudo apt-get install -y "$mysql_version"
    
    # Ask for PHP version
    echo "Which version of PHP do you want to install? (e.g. 'php7.4')"
    read php_version
    
    # Install PHP
    sudo apt-get install -y "$php_version" libapache2-mod-"$php_version" "$php_version"-mysql
    
    # Restart Apache to apply changes
    sudo service apache2 restart
    
elif [ "$os" = "Centos" ]; then
    # Update package manager
    sudo yum update
    
    # Install Apache
    sudo yum install -y httpd
    
    # Ask for MySQL version
    echo "Which version of MySQL do you want to install? (e.g. 'mysql57-community-release')"
    read mysql_version
    
    # Install MySQL
    sudo yum install -y "$mysql_version"
    
    # Ask for PHP version
    echo "Which version of PHP do you want to install? (e.g. 'php74')"
    read php_version
    
    # Install PHP
    sudo yum install -y "$php_version" "$php_version"-{fpm,bcmath,bz2,intl,gd,mbstring,mysql,zip,xml}
    
    # Start Apache 
    sudo systemctl start httpd
    sudo systemctl enable httpd
else
    echo "Invalid choice of Operating System"
fi
