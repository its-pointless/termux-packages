TERMUX_PKG_HOMEPAGE=http://www.fltk.org
TERMUX_PKG_DESCRIPTION="FLTK (pronounced 'fulltick') is a cross-platform C++ GUI toolkit"
TERMUX_PKG_VERSION=1.3.4
_version_suffix=-1
TERMUX_PKG_SRCURL=http://fltk.org/pub/fltk/$TERMUX_PKG_VERSION/fltk-${TERMUX_PKG_VERSION}${_version_suffix}-source.tar.gz
TERMUX_PKG_SHA256=7fb2c8882433ce694e6900c94fda505e8f4ed3fa9c7e597007098a33b85c53f4
TERMUX_PKG_FOLDERNAME=fltk-${TERMUX_PKG_VERSION}${_version_suffix}
TERMUX_PKG_DEPENDS="libx11, libjpeg-turbo, libpng"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--disable-gl
--x-libraries=$TERMUX_PREFIX/lib
--disable-localzlib
--disable-localpng
--disable-localjpeg
"
TERMUX_PKG_BUILD_IN_SRC=true
