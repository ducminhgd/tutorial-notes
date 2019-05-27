# Install PHP 7.1

```shell
add-apt-repository -y ppa:ondrej/php
apt-get update
apt-get install -y php7.1-dev php7.1-fpm php7.1-cli php7.1-common php7.1-mysql php7.1-sqlite3 php7.1-bcmath php7.1-xml php7.1-mbstring php7.1-opcache php7.1-json php7.1-curl php7.1-imap php7.1-intl php7.1-soap php7.1-mcrypt php7.1-gd php7.1-zip
```

# Install XDebug

```shell
apt-get install php-xdebug
```

Edit file `/etc/php/7.1/mods-available/xdebug.ini` like this

```ini
# /etc/php/7.1/mods-available/xdebug.ini
zend_extension=xdebug.so
xdebug.remote_enable=1
xdebug.remote_handler=dbgp
xdebug.remote_mode=req
xdebug.remote_host=localhost
xdebug.remote_port=9000
xdebug.var_display_max_depth = -1
xdebug.var_display_max_children = -1
xdebug.var_display_max_data = -1
```

# Find `.ini` files

```shell
php --ini
```