# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake virtualx

DESCRIPTION="A Qt implementation of XDG standards"
HOMEPAGE="https://lxqt.org/"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxqt/${PN}.git"
else
	SRC_URI="https://downloads.lxqt.org/downloads/${PN}/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="LGPL-2.1+ Nokia-Qt-LGPL-Exception-1.1"
SLOT="0"
IUSE="test"

BDEPEND="
	>=dev-util/lxqt-build-tools-0.6.0
	virtual/pkgconfig
"
RDEPEND="
	dev-qt/qtcore:6
	dev-qt/qtdbus:6
	dev-qt/qtgui:6=
	dev-qt/qtsvg:6
	dev-qt/qtwidgets:6
	dev-qt/qtxml:6
	x11-misc/xdg-utils
"
DEPEND="${RDEPEND}
	test? ( dev-qt/qttest:6 )
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTS=$(usex test)
	)
	cmake_src_configure
}

src_test() {
	# Tests don't work with C
	LC_ALL=en_US.utf8 virtx cmake_src_test
}
