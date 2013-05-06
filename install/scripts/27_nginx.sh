#!/bin/sh

# Only run on install
[[ "$1" != "install" ]] && exit 1

if [ "$MAILSERV_DEVEL" -eq "1" ]; then
  set -xv
fi

# Stop and delete the built-in nginx
/etc/rc.d/nginx stop
rm /usr/sbin/nginx /etc/rc.d/nginx

# Copy in our new rc file
/usr/bin/install -m 755 /var/mailserv/install/templates/nginx_rc.d /etc/rc.d/nginx
#Copy fastcgi_params file without the SSL directive that doesn't work under nginx 1.0
/usr/bin/install -m 755 /var/mailserv/install/templates/nginx_fastcgi_params /etc/nginx/fastcgi_params

