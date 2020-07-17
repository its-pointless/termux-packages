TERMUX_PKG_HOMEPAGE=https://libevent.org/
TERMUX_PKG_DESCRIPTION="Library that provides asynchronous event notification"
TERMUX_PKG_LICENSE="BSD 3-Clause"
TERMUX_PKG_VERSION=2.1.11
TERMUX_PKG_REVISION=2
TERMUX_PKG_SRCURL=https://github.com/libevent/libevent/archive/release-${TERMUX_PKG_VERSION}-stable.tar.gz
TERMUX_PKG_SHA256=229393ab2bf0dc94694f21836846b424f3532585bac3468738b7bf752c03901e
TERMUX_PKG_BREAKS="libevent-dev"
TERMUX_PKG_REPLACES="libevent-dev"
TERMUX_PKG_RM_AFTER_INSTALL="bin/event_rpcgen.py"

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DEVENT__BUILD_SHARED_LIBRARIES=ON
-DEVENT__DISABLE_BENCHMARK=ON
-DEVENT__DISABLE_OPENSSL=ON
-DEVENT__DISABLE_REGRESS=ON
-DEVENT__DISABLE_SAMPLES=ON
-DEVENT__DISABLE_TESTS=ON
-DEVENT__DISABLE_TESTS=ON
-DEVENT__HAVE_WAITPID_WITH_WNOWAIT=ON
-DEVENT__SIZEOF_PTHREAD_T=$((TERMUX_ARCH_BITS/8))
"
