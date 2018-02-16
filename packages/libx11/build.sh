TERMUX_PKG_VERSION=1.6.5
TERMUX_PKG_SRCURL=https://www.x.org/archive//individual/lib/libX11-$TERMUX_PKG_VERSION.tar.bz2
TERMUX_PKG_DEPENDS="x11-proto, xtrans, libxcb, libandroid-support"
TERMUX_PKG_SHA256=4d3890db2ba225ba8c55ca63c6409c1ebb078a2806de59fb16342768ae63435d
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-xthreads
--enable-malloc0returnsnull
"
