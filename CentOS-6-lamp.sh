#!/bin/bash
rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
yum --enablerepo=remi,remi-test -y install httpd mysql mysql-server php php-common
yum --enablerepo=remi,remi-test -y install php-mysql php-pgsql php-pecl-mongo php-sqlite php-pecl-memcache php-pecl-memcached php-gd php-mbstring php-mcrypt php-xml php-pecl-apc php-cli php-pear php-pdo phpmyadmin git
chkconfig --levels 235 httpd on
chkconfig --levels 235 mysqld on
/etc/init.d/httpd start
/etc/init.d/mysqld start
/usr/bin/mysqladmin -u root password 'vagrant'
/usr/bin/mysqladmin -u root -h localhost password 'vagrant'
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2222 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 9000 -j ACCEPT
service iptables save