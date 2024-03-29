# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2020-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=nebula
PKG_VERSION:=1.8.2
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=ea36949d8a355a0e546604d2033a410be8b0d058
PKG_SOURCE_URL:=https://github.com/slackhq/nebula
PKG_MIRROR_HASH:=5ea378372dd277b0340d38d975356910b9ff0ee6ce74c057fd1bff06e393ad02

include ../goenv.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/nebula/Default
	SECTION:=net
	CATEGORY:=Network
	TITLE:=a scalable overlay networking tool 
	URL:=https://github.com/slackhq/nebula
	MAINTAINER:=Entware team, https://entware.net
endef

define Package/nebula
	$(call Package/nebula/Default)
	VARIANT:=hf
endef

define Package/nebula_nohf
	$(call Package/nebula/Default)
	VARIANT:=nohf
	DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/nebula/description
 Nebula is a scalable overlay networking tool with a focus on performance,
 simplicity and security. It lets you seamlessly connect computers anywhere
 in the world. Nebula is portable, and runs on Linux, OSX, and Windows. It
 can be used to connect a small number of computers, but is also able to
 connect tens of thousands of computers.
endef

Package/nebula_nohf/description=$(Package/nebula/description)

GO_LDFLAGS += \
	-X 'main.Build=$(PKG_VERSION)'

GO_VARS += GO111MODULE=on

GO_TARGET:=./cmd/nebula ./cmd/nebula-cert

define Package/nebula/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/nebula $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/nebula-cert $(1)/opt/bin
endef

Package/nebula_nohf/install=$(Package/nebula/install)

$(eval $(call BuildPackage,nebula))
$(eval $(call BuildPackage,nebula_nohf))
