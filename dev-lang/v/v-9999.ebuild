# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck shell=sh # Written to be posix compatible
# shellcheck disable=SC2148,SC2034,SC3030,SC3054

EAPI="7"

inherit eutils git-r3

EGIT_REPO_URI="https://github.com/vlang/v.git"

DESCRIPTION="Statically typed compiled programming language"
HOMEPAGE="https://github.com/vlang/v"

IUSE="tcc clang"
REQUIRED_USE="tcc? ( !clang ) clang? ( !tcc )"

LICENSE="MIT"
SLOT="0"

RESTRICT="test network-sandbox"

DEPEND="
	tcc? (
		dev-lang/tcc
	)
	clang? (
		sys-devel/clang
	)
"
BDEPEND="
	$DEPEND
	sys-devel/gcc
"

src_compile() {
	if use clang; then
		# Force clang
		einfo "Enforcing the use of clang due to USE=clang"
		AR="llvm-ar"
		CC="$CHOST-clang"
		CXX="$CHOST-clang++"
		NM="llvm-nm"
		RANLIB="llvm-ranlib"
	elif use tcc; then
		# Force tcc
		einfo "Enforcing the use of gcc due to USE=tcc"
		AR="gcc-ar"
		CC="$CHOST-tcc"
		CXX="$CHOST-g++"
		NM="gcc-nm"
		RANLIB="gcc-ranlib"
	else
		# Force gcc
		einfo "Enforcing the use of gcc due to USE=-clang -tcc"
		AR="gcc-ar"
		CC="$CHOST-gcc"
		CXX="$CHOST-g++"
		NM="gcc-nm"
		RANLIB="gcc-ranlib"
	fi

	emake
}

src_install() {
	dodir "/usr/lib/vlang"
	insinto "/usr/lib/vlang"

	vfiles=("v" "v.mod" "cmd" "examples" "thirdparty" "vlib")
	for f in "${vfiles[@]}"; do
		doins -r "$f"
	done

	# Add necessary permissions
	fperms +x "/usr/lib/vlang/v"
	fperms ugo+rwx "/usr/lib/vlang/cmd/tools"

	dodoc README.md CHANGELOG.md
	dodoc -r doc

	dosym /usr/lib/vlang/v /usr/bin/v
}

pkg_postinst() {
	elog "The documentation files for $CATEGORY/$P"
	elog "can be found in /usr/share/doc/$P/{*md,doc/*.md}"
}
