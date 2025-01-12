# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

QT6_MODULE="qttools"
inherit desktop qt6-build xdg-utils

DESCRIPTION="Graphical tool that lets you introspect D-Bus objects and messages"

if [[ ${QT6_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc64 ~sparc ~x86"
fi

IUSE=""

DEPEND="
	~dev-qt/qtcore-${PV}
	~dev-qt/qtdbus-${PV}
	~dev-qt/qtgui-${PV}
	~dev-qt/qtwidgets-${PV}
	~dev-qt/qtxml-${PV}
"
RDEPEND="${DEPEND}"

QT6_TARGET_SUBDIRS=(
	src/qdbus/qdbusviewer
)

src_install() {
	qt6-build_src_install

	doicon -s 32 src/qdbus/qdbusviewer/images/qdbusviewer.png
	newicon -s 128 src/qdbus/qdbusviewer/images/qdbusviewer-128.png qdbusviewer.png
	make_desktop_entry "${QT6_BINDIR}"/qdbusviewer 'Qt 6 QDBusViewer' qdbusviewer 'Qt;Development'
}

pkg_postinst() {
	qt6-build_pkg_postinst
	xdg_icon_cache_update
}

pkg_postrm() {
	qt6-build_pkg_postrm
	xdg_icon_cache_update
}
