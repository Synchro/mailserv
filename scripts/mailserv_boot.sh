#!/bin/sh

echo -n "Starting mailserv daemons:"

# ensure correct file permissions are set
/usr/local/sbin/postfix set-permissions >/dev/null 2>&1
chgrp _dovecot /usr/local/libexec/dovecot/deliver
chmod 4750 /usr/local/libexec/dovecot/deliver
/usr/bin/newaliases

/usr/local/bin/mysqld_start

# Collect mail statistics
if [ -f /usr/local/awstats/wwwroot/cgi-bin/awstats.pl ]; then
  echo -n ' awstats'
  /usr/bin/perl /usr/local/awstats/wwwroot/cgi-bin/awstats.pl -config=`hostname` -update > /dev/null &
fi

# Start God system monitoring
if [ -x /usr/local/bin/god ]; then
  echo -n ' god'
  /usr/local/bin/god -c /etc/god/god.conf
fi

echo ''
