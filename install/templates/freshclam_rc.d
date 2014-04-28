#!/bin/sh
#
# $OpenBSD: nginx,v 1.1 2012/02/19 11:34:36 robert Exp $

daemon="/usr/local/bin/freshclam -d"

rc_pre() {
    mkdir -p /var/run/freshclam
    chown -R _clamav:_clamav /var/run/freshclam
}

. /etc/rc.d/rc.subr

rc_reload=NO

rc_cmd $1
