#!/bin/sh
#
# $OpenBSD: clamav_milter.rc,v 1.2 2012/01/21 23:13:59 ajacoutot Exp $

daemon="/usr/local/sbin/clamav-milter"

rc_pre() {
    mkdir -p /var/run/clamd
    chown -R _postfix:_postfix /var/run/clamd
}

. /etc/rc.d/rc.subr

rc_reload=NO

rc_cmd $1
