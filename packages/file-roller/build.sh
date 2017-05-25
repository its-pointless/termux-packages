TERMUX_PKG_HOMEPAGE=https://wiki.gnome.org/Apps/FileRoller
TERMUX_PKG_DESCRIPTION="Create and modify archives"
_major=3.24
TERMUX_PKG_VERSION=$_major.1
TERMUX_PKG_SRCURL=https://download.gnome.org/sources/file-roller/$_major/file-roller-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=011545e8bd81a415fb068718347bf63ced4ab176210ce36a668904a3124c7f3a
TERMUX_PKG_DEPENDS="gtk3, libarchive, file, zip, unzip, json-glib"
