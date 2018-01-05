TERMUX_PKG_HOMEPAGE=https://github.com/opencollab/arpack-ng
TERMUX_PKG_DESCRIPTION="Collection of Fortran77 subroutines designed to solve large scale eigenvalue problems."
TERMUX_PKG_VERSION=3.5.0
TERMUX_PKG_SHA256=50f7a3e3aec2e08e732a487919262238f8504c3ef927246ec3495617dde81239
TERMUX_PKG_SRCURL=https://github.com/opencollab/arpack-ng/archive/3.5.0.tar.gz
TERMUX_PKG_DEPENDS="openblas"
TERMUX_PKG_GCC7BUILD=yes
TERMUX_PKG_BUILD_IN_SRC=yes
termux_step_pre_configure() {
	autoreconf -if 
}
