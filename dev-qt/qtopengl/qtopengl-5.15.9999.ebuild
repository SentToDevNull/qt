# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

QT6_MODULE="qtbase"
VIRTUALX_REQUIRED="test"
inherit qt6-build

DESCRIPTION="OpenGL support library for the Qt6 framework (deprecated)"

if [[ ${QT6_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
fi

IUSE="gles2-only"

DEPEND="
	~dev-qt/qtcore-${PV}:6=
	~dev-qt/qtgui-${PV}[gles2-only=]
	~dev-qt/qtwidgets-${PV}[gles2-only=]
	!gles2-only? ( virtual/opengl )
"
RDEPEND="${DEPEND}"

QT6_TARGET_SUBDIRS=(
	src/opengl
)

src_configure() {
	local myconf=(
		-opengl $(usex gles2-only es2 desktop)
	)
	qt6-build_src_configure
}
