# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qt6-build

DESCRIPTION="3D data visualization library for the Qt6 framework"
LICENSE="GPL-3"

if [[ ${QT6_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

IUSE="gles2-only qml"

DEPEND="
	~dev-qt/qtcore-${PV}
	~dev-qt/qtgui-${PV}[gles2-only=]
	qml? ( ~dev-qt/qtdeclarative-${PV}[gles2-only=] )
"
RDEPEND="${DEPEND}"

src_prepare() {
	# eliminate bogus dependency on qtwidgets
	sed -i -e '/requires.*widgets/d' qtdatavis3d.pro || die

	qt_use_disable_mod qml quick \
		src/src.pro

	qt6-build_src_prepare
}
