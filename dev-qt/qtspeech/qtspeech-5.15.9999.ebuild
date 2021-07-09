# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qt6-build

DESCRIPTION="Text-to-speech library for the Qt6 framework"

if [[ ${QT6_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
fi

# TODO: flite plugin - needs 2.0.0 (not yet in tree)
IUSE=""

RDEPEND="
	>=app-accessibility/speech-dispatcher-0.8.7
	~dev-qt/qtcore-${PV}
"
DEPEND="${RDEPEND}"
