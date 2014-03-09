#!/bin/sh

if [ "$MAILSERV_DEVEL" -eq "1" ]; then
  set -xv
fi

if [ X"$PKG_PATH" == X"" ]; then
  export PKG_PATH=http://ftp.OpenBSD.org/pub/OpenBSD/`uname -r`/packages/`uname -m`/
fi

# Make sure PKG_PATH is stored permanently
if [ ! -f /etc/profile ]; then
  touch /etc/profile
fi
grep PKG_PATH /etc/profile || echo "export PKG_PATH=${PKG_PATH}" >> /etc/profile

case $1 in

  (install):
    echo "Installing packages"
    mkdir -p /var/db/spamassassin
    cat <<__EOT
    
You will be prompted to install:
 - postfix version. The recommendation is to install the first version 

Fetching versions:

__EOT
    pkg_add -v -m -i postfix--mysql 

    pkg_add -v -m -I \
     clamav \
     gnupg-2.0.19p3 \
     p5-Mail-SPF \
     p5-Mail-SpamAssassin \
     ruby-gems-1.8.23p0 \
     ruby-rake-0.9.2.2p0 \
     ruby-rrd \
     ruby-mysql-2.8.1p13 \
     ruby-mongrel \
     ruby-fastercsv-1.5.4p1 \
     ruby-iconv \
     god \
     dovecot-pigeonhole \
     dovecot-mysql \
     memcached \
     mysql-server \
     nginx-1.4.1 \
     sqlgrey \
     gsed \
     gtar-- \
     php-5.3.27-ap2 \
     php-mysqli-5.3.27 \
     php-pdo_mysql-5.3.27 \
     php-gd-5.3.27 \
     php-mcrypt-5.3.27 \
     ghostscript-fonts \
     ghostscript--no_x11 \
     ImageMagick \
     php-fpm \
     pecl-APC \
     pecl-memcache
     ;;

esac
