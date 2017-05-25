TERMUX_PKG_HOMEPAGE=http://ugetdm.com
TERMUX_PKG_DESCRIPTION="GTK+ download manager featuring download classification and HTML import"
TERMUX_PKG_VERSION=2.0.9
TERMUX_PKG_SRCURL=https://downloads.sourceforge.net/urlget/uget-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=5501c1d0c17e2e7b689eaaeae959d6c9c1f7855daf82086858efcb1e4d4208d6
TERMUX_PKG_DEPENDS="gtk3, libcurl, libandroid-support"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-notify
--disable-gstreamer
"
