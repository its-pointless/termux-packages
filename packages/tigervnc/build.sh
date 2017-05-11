TERMUX_PKG_HOMEPAGE="http://www.tigervnc.org"
TERMUX_PKG_VERSION=1.7.90
TERMUX_PKG_DESCRIPTION="Suite of VNC servers. Based on the VNC 4 branch of TightVNC."
TERMUX_PKG_DEPENDS="libgnutls, libjpeg-turbo, libxfont2, libpixman, libgcrypt, perl, xtrans, x11-proto, libx11, xorg-xauth, libandroid-shmem, gettext, xorg-server"
TERMUX_PKG_SRCURL=https://github.com/TigerVNC/tigervnc/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=0ddc43366b8399f591a24b35163a973bad129a1a7c1fcea7295fbfd8870c0a5f
TERMUX_PKG_FOLDERNAME=tigervnc-$TERMUX_PKG_VERSION
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-DBUILD_VIEWER=OFF -DENABLE_NLS=OFF -DENABLE_PAM=OFF -DENABLE_GNUTLS=OFF"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure () {
	mkdir -p $TERMUX_PKG_BUILDDIR/unix/xserver
	cd $TERMUX_PKG_BUILDDIR/unix/xserver

	#_xorg_server_name=xorg-server-1.19.1
	#tar xf $TERMUX_TOPDIR/xorg-server/cache/$_xorg_server_name.tar.bz2
	#mv $_xorg_server_name/* .
	#rmdir $_xorg_server_name

	#cp -R $TERMUX_PKG_SRCDIR/unix/xserver $TERMUX_PKG_BUILDDIR/unix/

	cp -R $TERMUX_TOPDIR/xorg-server/src/* $TERMUX_PKG_BUILDDIR/unix/xserver/

	patch -p1 < $TERMUX_PKG_SRCDIR/unix/xserver119.patch

	export ACLOCAL="aclocal -I ${TERMUX_PREFIX}/share/aclocal"
	autoreconf -fi

	CFLAGS="$CFLAGS -DFNDELAY=O_NDELAY -DINITARGS=void"
	LDFLAGS="$LDFLAGS -llog"

	./configure \
		--host="$TERMUX_HOST_PLATFORM" \
		--prefix="$TERMUX_PREFIX" \
		--disable-static \
		--disable-nls \
		--enable-debug \
		`TERMUX_PREFIX=$TERMUX_PREFIX bash $TERMUX_SCRIPTDIR/packages/xorg-server/build.sh xorg_server_flags`

	LDFLAGS="$LDFLAGS -landroid-shmem"
}

termux_step_post_make_install () {
	cd $TERMUX_PKG_BUILDDIR/unix/xserver
	make -j $TERMUX_MAKE_PROCESSES

	cd $TERMUX_PKG_BUILDDIR/unix/xserver/hw/vnc
	make install
}
