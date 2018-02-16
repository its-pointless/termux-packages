TERMUX_PKG_HOMEPAGE=https://www.gtk.org
_major=3.22
_minor=16
TERMUX_PKG_VERSION=$_major.$_minor
TERMUX_PKG_SRCURL=http://ftp.gnome.org/pub/gnome/sources/gtk+/$_major/gtk+-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=3e0c3ad01f3c8c5c9b1cc1ae00852bd55164c8e5a9c1f90ba5e07f14f175fe2c
TERMUX_PKG_DEPENDS="libcairo, libcairo-gobject, libxrender, libepoxy, gdk-pixbuf, pango, librsvg, libatk, libxi, fontconfig, libx11, libxext, libxfixes, adwaita-icon-theme, at-spi2-atk"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--disable-gtk-doc-html --disable-cups --enable-x11-backend --disable-glibtest"
