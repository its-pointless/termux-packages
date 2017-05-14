TERMUX_PKG_HOMEPAGE=https://cairographics.org
TERMUX_PKG_DESCRIPTION="Cairo 2D vector graphics library"
TERMUX_PKG_VERSION=1.14.12
TERMUX_PKG_SHA256=8c90f00c500b2299c0a323dd9beead2a00353752b2092ead558139bd67f7bf16
TERMUX_PKG_SRCURL=https://cairographics.org/releases/cairo-${TERMUX_PKG_VERSION}.tar.xz
<<<<<<< HEAD
TERMUX_PKG_DEPENDS="libandroid-support, libpixman, fontconfig, freetype, libpng"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_lzo2_lzo2a_decompress=no
--disable-gtk-doc-html
--enable-xlib=no
"
=======
TERMUX_PKG_SHA256=d1f2d98ae9a4111564f6de4e013d639cf77155baf2556582295a0f00a9bc5e20
TERMUX_PKG_DEPENDS="libandroid-support, libpixman, fontconfig, freetype, libandroid-shmem"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--disable-gtk-doc-html --enable-xlib=yes"
>>>>>>> libcairo: enable xlib
TERMUX_PKG_RM_AFTER_INSTALL="share/gtk-doc/html"

termux_step_pre_configure () {
	LDFLAGS="$LDFLAGS -landroid-shmem"
}
