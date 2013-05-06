#!/bin/sh
#
# $OpenBSD: nginx,v 1.1 2012/02/19 11:34:36 robert Exp $

daemon="/usr/local/bin/memcached -d"
daemon_flags="-m 64 -a 00777 -u _memcached -P /var/run/memcached/memcached.pid -s /var/run/memcached/memcached.sock"

. /etc/rc.d/rc.subr

rc_reload=NO

rc_cmd $1
