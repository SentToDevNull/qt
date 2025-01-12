# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="LXQt OpenSSH user password prompt tool"
HOMEPAGE="https://lxqt.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxqt/${PN}.git"
else
	SRC_URI="https://downloads.lxqt.org/downloads/${PN}/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="LGPL-2.1+"
SLOT="0"

BDEPEND="
	dev-qt/linguist-tools:6
	>=dev-util/lxqt-build-tools-0.6.0
"
RDEPEND="
	dev-qt/qtcore:6
	dev-qt/qtwidgets:6
	=lxqt-base/liblxqt-$(ver_cut 1-2)*
"
DEPEND="${RDEPEND}"

src_install(){
	cmake_src_install
	doman man/*.1

	echo "SSH_ASKPASS='${EPREFIX}/usr/bin/lxqt-openssh-askpass'" >> "${T}/99${PN}" \
		|| die
	doenvd "${T}/99${PN}"
}
