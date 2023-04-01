# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper

PKGREL="20230323"
DESCRIPTION="UML design application (Free 30-day trial)"
HOMEPAGE="https://www.visual-paradigm.com/download/"
SRC_URI="https://www.visual-paradigm.com/downloads/vp/Visual_Paradigm_${PV}_${PKGREL}_Linux64_InstallFree.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	local dir="/opt/${P}"

	insinto "${dir}"
	doins -r *
}
