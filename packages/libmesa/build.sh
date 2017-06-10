TERMUX_PKG_HOMEPAGE=https://www.mesa3d.org
TERMUX_PKG_VERSION=17.1.2
TERMUX_PKG_SRCURL=https://mesa.freedesktop.org/archive/mesa-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=0937804f43746339b1f9540d8f9c8b4a1bb3d3eec0e4020eac283b8799798239
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
