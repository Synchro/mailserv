#!/bin/sh
#
# $OpenBSD: clamd.rc,v 1.1 2011/01/05 06:06:49 ajacoutot Exp $

daemon="/usr/local/sbin/clamd"

rc_pre() {
    mkdir -p /var/run/clamd
    chown -R _postfix:_postfix /var/run/clamd
}

. /etc/rc.d/rc.subr

rc_reload=NO

rc_cmd $1
