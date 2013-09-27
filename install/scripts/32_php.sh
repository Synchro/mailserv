#!/bin/sh

# Only run on install
[[ "$1" != "install" ]] && exit 1

if [ "$MAILSERV_DEVEL" -eq "1" ]; then
  set -xv
fi

# Install php.ini file (this is a stock php.ini-production)
/usr/bin/install -m 644 /var/mailserv/install/templates/php-5.3.ini /etc/php-5.3.ini

# Install php-fpm.conf (replaces fast-cgi)
/usr/bin/install -m 644 /var/mailserv/install/templates/php-fpm.conf /etc/php-fpm.conf

# Install our local changes to php.ini
/usr/bin/install -m 644 /var/mailserv/install/templates/php-mailserv.ini /etc/php-5.3/mailserv.ini

# Symlink for mysql options
ln -sf /etc/php-5.3.sample/mysqli.ini /etc/php-5.3/mysqli.ini

# Symlink for mysql PDO driver options
ln -sf /etc/php-5.3.sample/pdo_mysql.ini /etc/php-5.3/pdo_mysql.ini

# Symlink for GD extension
ln -sf /etc/php-5.3.sample/gd.ini /etc/php-5.3/gd.ini

# Symlink for mcrypt extension
ln -sf /etc/php-5.3.sample/mcrypt.ini /etc/php-5.3/mcrypt.ini

# PHP APC config
/usr/bin/install -m 644 /var/mailserv/install/templates/apc.ini /etc/php-5.3/apc.ini

# PHP memcache config
/usr/bin/install -m 644 /var/mailserv/install/templates/memcache.ini /etc/php-5.3/memcache.ini

# Make php easier to run from CLI
ln -sf /usr/local/bin/php-5.3 /usr/local/bin/php

#Make sure FPM log is readable
touch /var/log/php-fpm.log
chmod 644 /var/log/php-fpm.log
