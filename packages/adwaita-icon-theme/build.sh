TERMUX_PKG_HOMEPAGE=https://www.gnome.org
TERMUX_PKG_VERSION=3.24.0
TERMUX_PKG_SRCURL=https://github.com/GNOME/adwaita-icon-theme/archive/$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=83ca4e44ea03112ecfbe52c2ebcdc58bb028af0c763c2b82cd9b3929d83aed5e
TERMUX_PKG_FOLDERNAME=adwaita-icon-theme-$TERMUX_PKG_VERSION
TERMUX_PKG_PLATFORM_INDEPENDENT=true

termux_step_pre_configure () {
	autoreconf -fiv
}
