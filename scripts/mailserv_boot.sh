#!/bin/sh

echo -n "Starting mailserv daemons:"

# ensure correct file permissions are set
/usr/local/sbin/postfix set-permissions >/dev/null 2>&1
chgrp _dovecot /usr/local/libexec/dovecot/deliver
chmod 4750 /usr/local/libexec/dovecot/deliver
/usr/bin/newaliases

/usr/local/bin/mysqld_start

if [ -x /usr/local/sbin/dovecot ]; then
  echo -n ' dovecot'; /usr/local/sbin/dovecot >/dev/null 2>&1
fi

# Update ClamAV databases
#This is launched via rc.conf.local
# if [ -x /usr/local/bin/freshclam ]; then
#  echo -n ' freshclam'
#  touch /var/run/freshclam.pid
#  chown _clamav:_clamav /var/run/freshclam.pid
#  /usr/local/bin/freshclam --daemon --no-warnings
#fi

# ClamAV Startup
if [ -x /usr/local/sbin/clamd ]; then
    chown _postfix /var/log/clamd.log
    rm -f /var/tmp/clamd
    touch /var/run/clamd.pid
    chown _postfix:_postfix /var/run/clamd.pid
    echo -n ' clamd'; /usr/local/sbin/clamd > /dev/null 2>&1
fi

#This is launched via rc.conf.local
#if [ -x /usr/local/bin/spamd ]; then
#  /usr/local/bin/spamd -s mail -u _spamd -dxq -r /var/run/spamd.pid -i 127.0.0.1
#fi

# Collect mail statistics
if [ -f /usr/local/awstats/awstats.pl ]; then
  echo -n ' awstats'
  perl /usr/local/awstats/awstats.pl -config=`hostname` -update > /dev/null &
fi

#This is launched via rc.conf.local
#if [ -x /usr/local/sbin/php-fpm-5.3 ]; then
#  echo -n ' php'
#  /usr/local/sbin/php-fpm-5.3 -y /etc/php-fpm.conf
#fi

#This is launched via rc.conf.local
#if [ -x /usr/local/sbin/nginx ]; then
#  echo -n ' nginx'
#  /usr/local/sbin/nginx
#fi

#This is launched via rc.conf.local
#if [ -x /usr/local/bin/memcached ]; then
#  echo -n ' memcached'
#  mkdir -p /var/run/memcached
#  chown -R _memcached:_memcached /var/run/memcached
#  /usr/local/bin/memcached -d -m 64 -u _memcached -P /var/run/memcached.pid -l 127.0.0.1 -p 11211
#fi

# Start God system monitoring
if [ -x /usr/local/bin/god ]; then
  echo -n ' god'
  /usr/local/bin/god -c /etc/god/god.conf
fi

echo ''
