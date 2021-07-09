# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

QT6_MODULE="qttools"
inherit desktop qt6-build xdg-utils

DESCRIPTION="Graphical tool for translating Qt applications"

if [[ ${QT6_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc64 ~x86"
fi

IUSE=""

DEPEND="
	~dev-qt/designer-${PV}
	~dev-qt/qtcore-${PV}:6=
	~dev-qt/qtgui-${PV}:6=
	~dev-qt/qtprintsupport-${PV}
	~dev-qt/qtwidgets-${PV}
	~dev-qt/qtxml-${PV}
"
RDEPEND="${DEPEND}"

QT6_TARGET_SUBDIRS=(
	src/linguist/linguist
)

src_install() {
	qt6-build_src_install

	local size
	for size in 16 32 48 64 128; do
		newicon -s ${size} src/linguist/linguist/images/icons/linguist-${size}-32.png linguist.png
	done
	make_desktop_entry "${QT6_BINDIR}"/linguist 'Qt 6 Linguist' linguist 'Qt;Development;Translation'
}

pkg_postinst() {
	qt6-build_pkg_postinst
	xdg_icon_cache_update
}

pkg_postrm() {
	qt6-build_pkg_postrm
	xdg_icon_cache_update
}
