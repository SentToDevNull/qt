# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit qt4-edge git-2

DESCRIPTION="GUI interface for git/cogito SCM"
HOMEPAGE="http://digilander.libero.it/mcostalba/"
EGIT_REPO_URI="git://git.kernel.org/pub/scm/${PN}/${PN}4.git"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS=""
IUSE=""

DEPEND="x11-libs/qt-gui:4"
RDEPEND="${DEPEND}
	>=dev-vcs/git-1.5.3"

src_install() {
	newbin bin/qgit qgit4
	dodoc README
}
