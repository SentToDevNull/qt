# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qt6-build

DESCRIPTION="Hardware sensor access library for the Qt6 framework"

if [[ ${QT6_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
fi

# TODO: simulator
IUSE="qml"

RDEPEND="
	~dev-qt/qtcore-${PV}
	~dev-qt/qtdbus-${PV}
	qml? ( ~dev-qt/qtdeclarative-${PV} )
"
DEPEND="${RDEPEND}"

src_prepare() {
	qt_use_disable_mod qml quick \
		src/src.pro

	qt6-build_src_prepare
}
