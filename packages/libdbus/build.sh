TERMUX_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/dbus
TERMUX_PKG_VERSION=1.10.20
TERMUX_PKG_SRCURL=https://dbus.freedesktop.org/releases/dbus/dbus-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=e574b9780b5425fde4d973bb596e7ea0f09e00fe2edd662da9016e976c460b48
TERMUX_PKG_DEPENDS="libexpat"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-x11-autolaunch
--with-system-pid-file=$TERMUX_PREFIX/var/run/dbus/pid
--with-system-socket=$TERMUX_PREFIX/var/run/dbus/sock
--with-session-socket-dir=$TERMUX_PREFIX/var/run/dbus
"

termux_step_pre_configure () {
	LDFLAGS="$LDFLAGS -llog"
}

termux_step_post_massage () {
	mkdir -p $TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/var/run/dbus
	mkdir -p $TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/var/lib/dbus
}

termux_step_create_debscripts () {
	cat > postinst <<HERE
if [ ! -f \$PREFIX/var/lib/dbus/machine-id ]; then
	echo 'Generating new machine uuid...'
	dbus-uuidgen > \$PREFIX/var/lib/dbus/machine-id
fi
exit 0
HERE
	chmod 0755 postinst
}
