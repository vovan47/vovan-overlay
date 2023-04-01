# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="PCRE wrapping library that offers type-safe preg_* replacements."
HOMEPAGE="https://github.com/composer/pcre"
SRC_URI="https://github.com/composer/pcre/archive/${PV}.tar.gz -> ${P}.tar.gz"

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
	insinto '/usr/share/php/Composer/Pcre'
	doins -r src/*

	einstalldocs
}
