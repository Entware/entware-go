# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2022-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=lux
PKG_VERSION:=0.24.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=348ae97219784a32dd3c4721ad0cbc2584ee7b46
PKG_SOURCE_URL:=https://github.com/iawia002/lux
PKG_MIRROR_HASH:=b65af44eca517015d42f2679d7157642c759ff954a4adf044b84b55001bfc7fa

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/lux/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Download Manager
	TITLE:=a fast, simple and clean video downloader
	URL:=https://github.com/iawia002/lux
	MAINTAINER:=Entware team, https://entware.net
	DEPENDS:=+ffmpeg
endef

define Package/lux
	$(call Package/lux/Default)
	VARIANT:=hf
endef

define Package/lux_nohf
	$(call Package/lux/Default)
	VARIANT:=nohf
	DEPENDS+=@arm
endef

define Package/lux/description
 A fast, simple and clean video downloader built with Go (command line).
endef

Package/lux_nohf/description=$(Package/lux/description)

GO_VARS += GO111MODULE=on

define Package/lux/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/lux $(1)/opt/bin
endef

Package/lux_nohf/install=$(Package/lux/install)

$(eval $(call BuildPackage,lux))
$(eval $(call BuildPackage,lux_nohf))
