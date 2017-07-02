TERMUX_PKG_HOMEPAGE=https://www.mesa3d.org
TERMUX_PKG_VERSION=17.1.4
TERMUX_PKG_SRCURL=https://mesa.freedesktop.org/archive/mesa-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=06f3b0e6a28f0d20b7f3391cf67fe89ae98ecd0a686cd545da76557b6cec9cad
TERMUX_PKG_DEPENDS="libxml2, libx11, x11-proto, libdrm, libxdamage, libxshmfence, libandroid-shmem"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-gles1
--disable-gles2
--enable-libdrm
--enable-dri3
--disable-gbm
--disable-egl
--with-platforms=x11
--without-dri-drivers
--without-gallium-drivers
--enable-glx=dri
ac_cv_header_xlocale_h=no
"

termux_step_pre_configure () {
	LDFLAGS="$LDFLAGS -landroid-shmem"
}
