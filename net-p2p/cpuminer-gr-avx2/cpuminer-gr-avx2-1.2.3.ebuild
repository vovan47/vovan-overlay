EAPI=7

inherit autotools flag-o-matic systemd

DESCRIPTION="Optimised Version of GR miner for RTM"
HOMEPAGE="https://github.com/WyvernTKC/cpuminer-gr-avx2/"
LICENSE="GPL-2"
SLOT="0"
DEPEND="
	dev-libs/gmp:=
	dev-libs/jansson:=
	>=net-misc/curl-7.15[ssl]
	dev-libs/openssl:0=
"
RDEPEND="${DEPEND}"
KEYWORDS="~amd64"
SRC_URI="https://github.com/WyvernTKC/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

PATCHES=( "${FILESDIR}/donation_clean.patch" )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	append-cxxflags -std=c++20
	append-cxxflags -Wno-ignored-attributes
	append-ldflags -Wl,-z,noexecstack
	econf --with-crypto --with-curl
}

src_install() {
	default
	systemd_dounit "${FILESDIR}"/${PN}.service
}

src_test() {
	./cpuminer --cputest || die
}
