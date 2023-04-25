# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Symfony DependencyInjection Component"
HOMEPAGE="https://github.com/symfony/contracts"
SRC_URI="https://github.com/symfony/contracts/archive/v${PV}.tar.gz
	-> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

# The test suite requires the unpackaged symfony-expression-language.
RESTRICT=test

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	"
DEPEND="test? ( ${RDEPEND} >=dev-php/phpunit-5.7.15 )"

S="${WORKDIR}/contracts-${PV}"

src_prepare() {
	default
}

src_install() {
	insinto "/usr/share/php/Symfony/Component/Contracts"
	doins -r Cache Deprecation EventDispatcher HttpClient Service Tests Translation
	doins "${FILESDIR}/autoload.php"
	dodoc CHANGELOG.md README.md
}
