#
# Copyright (C) 2011-2019 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=gotty
PKG_VERSION:=2.0.0-2017-12-13
PKG_RELEASE:=1
PKG_GOGET:=github.com/yudai/gotty

GOPKG_SOURCE=GO_$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE).tar.bz2

#!!! uncomment PKG_SOURCE to download fixed version
PKG_SOURCE=$(GOPKG_SOURCE)
PKG_COMMIT=a080c85cbc59226c94c6941ad8c395232d72d517

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

ifeq ($(BUILD_VARIANT),nohf)
GOARM=GOARM=5
endif

define Package/gotty/Default
	$(call Package/gopackage/Default)
	TITLE:=GoTTY is a simple command line tool that turns your CLI tools into web applications.
	URL:=https://github.com/yudai/gotty
endef

define Package/gotty
	$(call Package/gotty/Default)
	VARIANT:=hf
endef

define Package/gotty_nohf
	$(call Package/gotty/Default)
	VARIANT:=nohf
	DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/gotty/description
 GoTTY - Share your terminal as a web application.
endef

Package/gotty_nohf/description=$(Package/gotty/description)

define Package/gotty/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/$(PKG_NAME) $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/$(PKG_NAME)
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/$(PKG_GOGET)/.gotty $(1)/opt/etc/$(PKG_NAME)/gotty
	$(SED) 's!~/.!/opt/etc/gotty/!g' $(1)/opt/etc/$(PKG_NAME)/gotty
endef

Package/gotty_nohf/install=$(Package/gotty/install)

$(eval $(call BuildPackage,gotty))
$(eval $(call BuildPackage,gotty_nohf))
