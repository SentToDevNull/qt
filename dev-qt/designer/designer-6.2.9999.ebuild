# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

QT6_MODULE="qttools"
inherit desktop qt6-build xdg-utils

DESCRIPTION="WYSIWYG tool for designing and building graphical user interfaces with QtWidgets"

if [[ ${QT6_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~x86"
fi

IUSE="declarative"

DEPEND="
	~dev-qt/qtcore-${PV}:6=
	~dev-qt/qtgui-${PV}:6=
	~dev-qt/qtnetwork-${PV}
	~dev-qt/qtprintsupport-${PV}
	~dev-qt/qtwidgets-${PV}
	~dev-qt/qtxml-${PV}
	declarative? ( ~dev-qt/qtdeclarative-${PV}[widgets] )
"
RDEPEND="${DEPEND}"

src_prepare() {
	qt_use_disable_mod declarative quickwidgets \
		src/designer/src/plugins/plugins.pro

	sed -e "s/qtHaveModule(webkitwidgets)/false/g" \
		-i src/designer/src/plugins/plugins.pro || die

	qt6-build_src_prepare
}

src_install() {
	qt6-build_src_install

	doicon -s 128 src/designer/src/designer/images/designer.png
	make_desktop_entry "${QT6_BINDIR}"/designer 'Qt 6 Designer' designer 'Qt;Development;GUIDesigner'
}

pkg_postinst() {
	qt6-build_pkg_postinst
	xdg_icon_cache_update
}

pkg_postrm() {
	qt6-build_pkg_postrm
	xdg_icon_cache_update
}
