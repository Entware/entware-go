#
# Copyright (C) 2011-2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=shell2http
PKG_VERSION:=2022-08-20
PKG_RELEASE:=1

_PKG_VERSION:=1.14.2

PKG_GOGET:=github.com/msoap/shell2http

PKG_SOURCE_VERSION:=9f2fb96730804292cea53fc69ac26511ac2b2cfc

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://$(PKG_GOGET)
PKG_MIRROR_HASH:=c51d461a5cea0d3c5eced99f2a0e2ccca6d88b4c37ac4547db18104fd271ef45

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/shell2http/Default
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Execute shell commands via simple http server
	URL:=https://github.com/msoap/shell2http
	MAINTAINER:=Entware team, https://entware.net
endef

define Package/shell2http
	$(call Package/shell2http/Default)
	VARIANT:=hf
endef

define Package/shell2http_nohf
	$(call Package/shell2http/Default)
	VARIANT:=nohf
	DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/shell2http/description
 Executing shell commands via simple http server (written in Go language).
 Settings through 2 command line arguments, path and shell command.
 By default bind to :8080.
endef

Package/shell2http_nohf/description=$(Package/shell2http/description)

GO_LDFLAGS += \
	-X 'main.version=$(_PKG_VERSION)'

GO_VARS += GO111MODULE=on

define Package/shell2http/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/$(PKG_NAME) $(1)/opt/bin
endef

Package/shell2http_nohf/install=$(Package/shell2http/install)

$(eval $(call BuildPackage,shell2http))
$(eval $(call BuildPackage,shell2http_nohf))
