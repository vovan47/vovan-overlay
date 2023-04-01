# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Utilities to generate class maps and scan PHP code."
HOMEPAGE="https://github.com/composer/class-map-generator"
SRC_URI="https://github.com/composer/class-map-generator/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

BDEPEND="dev-php/theseer-Autoload"

RDEPEND="dev-php/fedora-autoloader
	>=dev-lang/php-7.2:*"

src_prepare() {
	default

	phpab \
		--output src/autoload.php \
		--template fedora2 \
		--basedir src \
		src \
		|| die
}

src_install() {
	insinto '/usr/share/php/Composer/ClassMapGenerator'
	doins -r src/* "${FILESDIR}/autoload.php"
	dodoc README.md
}
