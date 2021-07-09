# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

QT6_MODULE="qttools"
inherit desktop qt6-build xdg-utils

DESCRIPTION="Tool for viewing on-line documentation in Qt help file format"

if [[ ${QT6_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc64 ~sparc ~x86"
fi

IUSE=""

DEPEND="
	~dev-qt/qtcore-${PV}:6=
	~dev-qt/qtgui-${PV}
	~dev-qt/qthelp-${PV}
	~dev-qt/qtnetwork-${PV}
	~dev-qt/qtprintsupport-${PV}
	~dev-qt/qtsql-${PV}[sqlite]
	~dev-qt/qtwidgets-${PV}
"
RDEPEND="${DEPEND}"

QT6_TARGET_SUBDIRS=(
	src/assistant/assistant
)

src_prepare() {
	sed -e "s/qtHaveModule(webkitwidgets)/false/g" \
		-i src/assistant/assistant/assistant.pro || die

	qt6-build_src_prepare
}

src_install() {
	qt6-build_src_install

	doicon -s 32 src/assistant/assistant/images/assistant.png
	newicon -s 128 src/assistant/assistant/images/assistant-128.png assistant.png
	make_desktop_entry "${QT6_BINDIR}"/assistant 'Qt 6 Assistant' assistant 'Qt;Development;Documentation'
}

pkg_postinst() {
	qt6-build_pkg_postinst
	xdg_icon_cache_update
}

pkg_postrm() {
	qt6-build_pkg_postrm
	xdg_icon_cache_update
}
