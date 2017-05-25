TERMUX_PKG_HOMEPAGE=https://www.mesa3d.org
TERMUX_PKG_VERSION=17.1.0
TERMUX_PKG_SRCURL=https://mesa.freedesktop.org/archive/mesa-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=cf234a6ed4764673886b6661553b54675776ef0898f774716173cec890ac3b17
TERMUX_PKG_DEPENDS="libxml2, libx11, x11-proto, libdrm, libandroid-shmem"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-gles1
--disable-gles2
--enable-libdrm
--enable-glx=dri
--enable-dri3
--disable-gbm
--enable-egl
--with-platforms=x11
--without-gallium-drivers
ac_cv_header_xlocale_h=no
"

termux_step_pre_configure () {
	LDFLAGS="$LDFLAGS -landroid-shmem"
}
