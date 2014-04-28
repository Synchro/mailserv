#!/bin/sh
#
# $OpenBSD: nginx,v 1.1 2012/02/19 11:34:36 robert Exp $

daemon="/usr/local/bin/memcached -d"

rc_pre() {
    mkdir -p /var/run/memcached
    chown -R _memcached:_memcached /var/run/memcached
}

. /etc/rc.d/rc.subr

rc_reload=NO

rc_cmd $1
