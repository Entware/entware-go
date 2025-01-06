# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2020-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=nebula
PKG_VERSION:=1.9.5
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/slackhq/nebula
PKG_MIRROR_HASH:=40411aa00d158380eaad4e3a6a600f0254b202c3ba3582e7db52338caafcd4c9

PKG_BUILD_PARALLEL:=1

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
	DEPENDS:=@arm
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
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/nebula{,-cert} $(1)/opt/bin
endef

Package/nebula_nohf/install=$(Package/nebula/install)

$(eval $(call BuildPackage,nebula))
$(eval $(call BuildPackage,nebula_nohf))
