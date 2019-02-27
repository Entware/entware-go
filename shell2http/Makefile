#
# Copyright (C) 2011-2019 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=shell2http
PKG_VERSION:=2018-12-09
PKG_RELEASE:=1
PKG_GOGET:=github.com/msoap/shell2http

GOPKG_SOURCE=GO_$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE).tar.bz2

#!!! uncomment PKG_SOURCE to download fixed version
PKG_SOURCE=$(GOPKG_SOURCE)

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

ifeq ($(BUILD_VARIANT),nohf)
GOARM=GOARM=5
endif

define Package/shell2http/Default
	$(call Package/gopackage/Default)
	TITLE:=Execute shell commands via simple http server
	URL:=https://github.com/msoap/shell2http
endef

define Package/shell2http
	$(call Package/shell2http/Default)
	VARIANT:=hf
endef

define Package/shell2http_nohf
	$(call Package/shell2http/Default)
	VARIANT:=nohf
	DEPENDS:=@TARGET_armv7_3_2||@TARGET_armv7_2_6
endef

define Package/shell2http/description
 Executing shell commands via simple http server (written in Go language).
 Settings through 2 command line arguments, path and shell command. By default bind to :8080.
endef

Package/shell2http_nohf/description=$(Package/shell2http/description)

define Package/shell2http/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/$(PKG_NAME) $(1)/opt/bin
endef

Package/shell2http_nohf/install=$(Package/shell2http/install)

$(eval $(call BuildPackage,shell2http))
$(eval $(call BuildPackage,shell2http_nohf))
