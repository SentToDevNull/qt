# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

QT6_MODULE="qtbase"
VIRTUALX_REQUIRED="test"
inherit qt6-build

DESCRIPTION="Printing support library for the Qt6 framework"

if [[ ${QT6_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
fi

IUSE="cups gles2-only"

RDEPEND="
	~dev-qt/qtcore-${PV}:6=
	~dev-qt/qtgui-${PV}[gles2-only=]
	~dev-qt/qtwidgets-${PV}[gles2-only=]
	cups? ( >=net-print/cups-1.4 )
"
DEPEND="${RDEPEND}
	test? ( ~dev-qt/qtnetwork-${PV} )
"

QT6_TARGET_SUBDIRS=(
	src/printsupport
	src/plugins/printsupport
)

QT6_GENTOO_CONFIG=(
	cups
)

src_configure() {
	local myconf=(
		$(qt_use cups)
		-opengl $(usex gles2-only es2 desktop)
	)
	qt6-build_src_configure
}
