#!/bin/sh
#
# $OpenBSD: spamd,v 1.2 2011/07/08 02:15:34 robert Exp $

daemon="/usr/local/bin/spamd"

. /etc/rc.d/rc.subr

pexp="perl: /usr/local/bin/spamd"

rc_cmd $1
