#!/bin/sh

# Only run on install
[[ "$1" != "install" ]] && exit 1

if [ "$MAILSERV_DEVEL" -eq "1" ]; then
  set -xv
fi

mkdir -p /var/run/memcached
chown -R _memcached:_memcached /var/run/memcached
/usr/bin/install -m 755 /var/mailserv/install/templates/memcached_rc.d /etc/rc.d/memcached
