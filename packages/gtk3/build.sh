TERMUX_PKG_HOMEPAGE=https://www.gtk.org
_major=3.22
_minor=12
TERMUX_PKG_VERSION=$_major.$_minor
TERMUX_PKG_SRCURL=http://ftp.gnome.org/pub/gnome/sources/gtk+/$_major/gtk+-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=84fae0cefb6a11ee2b4e86b8ac42fe46a3d30b4ad16661d5fc51e8ae03e2a98c
TERMUX_PKG_DEPENDS="libcairo, libcairo-gobject, libxrender, libepoxy, gdk-pixbuf, pango, librsvg, libatk, libxi, fontconfig, libx11, libxext, libxfixes, adwaita-icon-theme"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--disable-gtk-doc-html --disable-cups --enable-x11-backend --disable-glibtest"
