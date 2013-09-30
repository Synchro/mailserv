#!/bin/sh
#
# $OpenBSD: nginx,v 1.1 2012/02/19 11:34:36 robert Exp $

daemon="/usr/local/bin/memcached -d"
daemon_flags="-m 64 -u _memcached -P /var/run/memcached/memcached.pid -l 127.0.0.1 -p 11211"

. /etc/rc.d/rc.subr

rc_reload=NO

rc_cmd $1
