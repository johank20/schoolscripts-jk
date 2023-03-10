#!/bin/bash

# Ask for Operating System 
echo "Which Operating System are you using? (Ubuntu, Debian, Centos)"
read os

if [ "$os" = "Ubuntu" ] || [ "$os" = "Debian" ]; then


# Ask if update system 
echo "Do you want to update your system before installation? (Y/N)"
read update
if [ "$update" = "Y" ]; then
    apt update && apt -y full-upgrade
    fi
    echo "Reboot machine? (Y/N)"
    read autoreboot
    if [ "$autoreboot" = "Y" ]; then
        reboot 
    else
        echo "Continuing with installation without reboot"
    fi
else
    echo "Continuing with installation without update"
fi


    
    #Add php PPA
    sudo apt update -y
    sudo apt -y install software-properties-common
    sudo add-apt-repository ppa:ondrej/php -y
    sudo apt update -y
    
    # Install Apache
    sudo apt-get install -y apache2
    
    # Ask for MySQL version
    echo "Which version of MySQL do you want to install? (e.g. 'mysql' or 'mariadb')"
    read mysql
    
    if [ "$mysql" = "Mariadb" ]; then
    
        #if mariadb Install mariadb
        sudo apt-get install -y mariadb-client mariadb-server
    else
        #if mysql install mysql
        sudo apt-get install libaio1
        sudo apt install -y mysql-server mysql-client
    fi
    # Ask for PHP version
    echo "Which version of PHP do you want to install? (e.g. 'php7.4')"
    read php_version
    
    # Install PHP
    sudo apt-get install -y "$php_version" libapache2-mod-"$php_version" "$php_version"-{fpm,bcmath,bz2,intl,gd,mbstring,mysql,zip,xml}
    
    # Restart Apache to apply changes
    sudo service apache2 restart
    
    #start mysql install
    sudo mysql-secure-installation
    
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
