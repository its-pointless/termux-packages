TERMUX_PKG_HOMEPAGE=https://freedesktop.org/Software/shared-mime-info
TERMUX_PKG_VERSION=1.8
TERMUX_PKG_SRCURL=https://freedesktop.org/~hadess/shared-mime-info-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=2af55ef1a0319805b74ab40d331a3962c905477d76c086f49e34dc96363589e9
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--disable-update-mimedb"

termux_step_create_debscripts () {
	echo "update-mime-database --ignore-fail-on-non-empty \$PREFIX/share/mime" > postinst
	echo "exit 0" >> postinst
}
