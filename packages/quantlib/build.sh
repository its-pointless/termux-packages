TERMUX_PKG_HOMEPAGE=http://quantlib.org
TERMUX_PKG_DESCRIPTION="a comprehensive software framework for quantitative finance"
TERMUX_PKG_VERSION=1.11
TERMUX_PKG_SRCURL=https://sourceforge.net/projects/quantlib/files/QuantLib/1.11/QuantLib-1.11.tar.gz
TERMUX_PKG_SHA256=ef420d584233cb83a28245315dec2a1edda5fdbdf7a655fee7afc83ba5c0dee8
#TERMUX_PKG_SHA256=bcb88be6a485ae62bb00027c180294d2af0dbea252e4f76e1284e4af3a9c4432
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="  --enable-intraday"
TERMUX_PKG_INCLUDE_IN_DEVPACKAGE="bin/quantlib-config"
TERMUX_PKG_DEVPACKAGE_DEPENDS="boost-dev"
TERMUX_PKG_BUILD_IN_SRC=yes
TERMUX_PKG_BUILD_DEPENDS="boost"
#TERMUX_PKG_FORCE_CMAKE=yes
#termux_step_pre_configure() {
#	autoreconf -if
#}
