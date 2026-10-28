# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2016-2026 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=shell2http
PKG_VERSION:=2026-10-11
PKG_RELEASE:=1

PKG_REAL_VERSION:=1.18.0

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=0f1d44c5237be754940d69b4b0ffddd9c63796d3
PKG_SOURCE_URL:=https://github.com/msoap/shell2http
PKG_MIRROR_HASH:=2d343a17e86f555546980402fa800046fe66ec93f4d5fb0df909ec2af9e382c9

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/shell2http/Default
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Executing shell commands via HTTP server
  URL:=https://github.com/msoap/shell2http
  PROVIDES:=shell2http
endef

define Package/shell2http
  $(call Package/shell2http/Default)
  VARIANT:=hf
  DEFAULT_VARIANT:=1
endef

define Package/shell2http_nohf
  $(call Package/shell2http/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/shell2http/description
 HTTP-server designed to execute shell commands.
endef

Package/shell2http_nohf/description=$(Package/shell2http/description)

GO_LDFLAGS += \
	-X 'main.version=$(PKG_REAL_VERSION)'

GO_VARS += GO111MODULE=on

define Package/shell2http/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/shell2http $(1)/opt/bin
endef

Package/shell2http_nohf/install=$(Package/shell2http/install)

$(eval $(call BuildPackage,shell2http))
$(eval $(call BuildPackage,shell2http_nohf))
