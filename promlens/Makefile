# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2024 Entware
#
# XXX mips(el): modernc.org/libc/**: build constraints exclude all Go files in ***

include $(TOPDIR)/rules.mk

PKG_NAME:=promlens
PKG_VERSION:=0.3.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2022-12-05
PKG_SOURCE_VERSION:=759372f2207b1c8e46c210e822b5e8fdc92ea6a7
PKG_SOURCE_URL:=https://github.com/prometheus/promlens
PKG_MIRROR_HASH:=ad567a1cba0ff5c5cf429908f2a3d9ef017d51865f69a6a8037f45f156e712e2

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DEPENDS:=node/host

include ../goenv.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/promlens/Default
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=prometheus tools
  TITLE:=The query builder, analyzer, and explainer for PromQL
  URL:=http://prometheus.io
  MAINTAINER:=Entware team, https://entware.net
  DEPENDS:=@!(mips||mipsel)
endef

define Package/promlens
  $(call Package/promlens/Default)
  VARIANT:=hf
endef

define Package/promlens_nohf
  $(call Package/promlens/Default)
  VARIANT:=nohf
  DEPENDS+=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/promlens/description
  PromLens is a web-based PromQL query builder, analyzer, and visualizer.
endef

Package/promlens_nohf/description=$(Package/promlens/description)

GO_BUILD_ARGS += -a

GO_LDFLAGS += \
	-X 'github.com/prometheus/common/version.Version=v$(PKG_VERSION)' \
	-X 'github.com/prometheus/common/version.Revision=$(COMMIT_SHORT)'  \
	-X 'github.com/prometheus/common/version.Branch="release"' \
	-X 'github.com/prometheus/common/version.BuildUser=Entware@Entware' \
	-X 'github.com/prometheus/common/version.BuildDate=$(PKG_SOURCE_DATE)'

GO_TAGS:=-tags=netgo,builtinassets

GO_TARGET:=./cmd/promlens

define Build/CompilePre
	( cd $(PKG_BUILD_DIR)/app; \
		CI=false PUBLIC_URL=. npm install; \
		CI=false NODE_OPTIONS=--openssl-legacy-provider PUBLIC_URL=. npm run build; \
	)
	( cd $(PKG_BUILD_DIR); $(SHELL) scripts/compress_assets.sh; )
endef

Hooks/Compile/Pre += Build/CompilePre

define Package/promlens/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/promlens $(1)/opt/bin
endef

Package/promlens_nohf/install=$(Package/promlens/install)

$(eval $(call BuildPackage,promlens))
$(eval $(call BuildPackage,promlens_nohf))
