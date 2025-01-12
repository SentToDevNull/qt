# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qt6-build

DESCRIPTION="Chart component library for the Qt6 framework"
LICENSE="GPL-3"

if [[ ${QT6_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
fi

IUSE="qml"

DEPEND="
	~dev-qt/qtcore-${PV}
	~dev-qt/qtgui-${PV}
	~dev-qt/qtwidgets-${PV}
	qml? ( ~dev-qt/qtdeclarative-${PV} )
"
RDEPEND="${DEPEND}"

src_prepare() {
	qt_use_disable_mod qml quick \
		src/src.pro

	qt6-build_src_prepare
}
