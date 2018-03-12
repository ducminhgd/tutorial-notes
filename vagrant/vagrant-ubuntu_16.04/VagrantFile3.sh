
apt-get update
apt-get install -y bash-completion
apt-get install -y python-pip
apt-get install -y rabbitmq-server

    # MySQL
DBUSER=dev
DBPASSWD=mysql
debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBPASSWD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBPASSWD"

# RabbitMQ
echo "deb http://www.rabbitmq.com/debian/ testing main" >> /etc/apt/sources.list
wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
apt-key add rabbitmq-signing-key-public.asc

# Redis
add-apt-repository -y ppa:chris-lea/redis-server

# PHP 7.1
apt-get install -y python-software-properties
add-apt-repository -y ppa:ondrej/php

apt-get update

apt-get install -y nginx
apt-get install -y mysql-server
apt-get install -y --allow-unauthenticated rabbitmq-server
apt-get install -y redis-server
apt-get install -y memcached

# Python
apt-get -y install python-pip
pip install --upgrade pip
pip install virtualenv
add-apt-repository ppa:deadsnakes/ppa -y
apt-get update
apt-get install -y python3.6
mkdir /venvs
# cd /venvs
# virtualenv --python=/usr/bin/python3 default

# PHP 7.1
apt-get install -y php7.1-dev php7.1-fpm php7.1-cli php7.1-common php7.1-mysql php7.1-sqlite3 php7.1-bcmath php7.1-xml php7.1-mbstring php7.1-opcache php7.1-json php7.1-curl php7.1-imap php7.1-intl php7.1-soap php7.1-mcrypt php7.1-gd php7.1-zip

# Composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer

# Alter binding config for MySQL, Redis
echo "\nUpdating MySQL binding...\n"
sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
systemctl restart mysql

echo "\nUpdating Redis binding...\n"
sed -i "s/^bind .*/bind 0.0.0.0/" /etc/redis/redis.conf
systemctl restart redis

echo -e "\nCreating MySQL user...\n"
mysql -uroot -p$DBPASSWD -e "CREATE USER '$DBUSER'@'%' IDENTIFIED BY '$DBPASSWD';" >> /vagrant/vm_build.log 2>&1
mysql -uroot -p$DBPASSWD -e "GRANT ALL PRIVILEGES ON *.* TO '$DBUSER'@'%' WITH GRANT OPTION;" > /vagrant/vm_build.log 2>&1