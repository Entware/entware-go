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
PKG_MIRROR_HASH:=0104665451f56178e00d4b936310f75b7d2de767bfce101923f332c220b7d9ac

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DEPENDS:=node/host
PKG_BUILD_PARALLEL:=1

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
  DEPENDS+=@arm
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

GO_TAGS:=builtinassets, netgo

GO_TARGET:=./cmd/promlens

define Build/CompilePre
	( cd $(PKG_BUILD_DIR)/app; \
		CI=false PUBLIC_URL=. npm install; \
		CI=false NODE_OPTIONS=--openssl-legacy-provider \
			PUBLIC_URL=. npm run build; \
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
