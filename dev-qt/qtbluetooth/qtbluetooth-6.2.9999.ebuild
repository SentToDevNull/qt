# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

QT6_MODULE="qtconnectivity"
inherit qt6-build

DESCRIPTION="Bluetooth support library for the Qt6 framework"

if [[ ${QT6_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
fi

IUSE="qml"

RDEPEND="
	~dev-qt/qtconcurrent-${PV}
	~dev-qt/qtcore-${PV}:6=
	~dev-qt/qtdbus-${PV}
	>=net-wireless/bluez-5:=
	qml? ( ~dev-qt/qtdeclarative-${PV} )
"
DEPEND="${RDEPEND}
	~dev-qt/qtnetwork-${PV}
"

src_prepare() {
	sed -i -e 's/nfc//' src/src.pro || die

	qt_use_disable_mod qml quick src/src.pro

	qt6-build_src_prepare
}
