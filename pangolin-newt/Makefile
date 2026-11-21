# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2026 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=pangolin-newt
PKG_VERSION:=1.20.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/fosrl/newt/tar.gz/refs/tags/$(PKG_VERSION)?
PKG_HASH:=6e87f6e93f5504e1917f99e5487bf3af7a5af19bf332130af026466174b7951e

PKG_LICENSE:=AGPL-3.0-only
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DIR:=$(BUILD_DIR)/$(if $(BUILD_VARIANT),$(PKG_NAME)-$(BUILD_VARIANT)/)newt-$(PKG_VERSION)
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/pangolin-newt/Default
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Pangolin site connector
  URL:=https://github.com/fosrl/newt
  DEPENDS:=+ca-bundle
  PROVIDES:=pangolin-newt
endef

define Package/pangolin-newt
  $(call Package/pangolin-newt/Default)
  VARIANT:=hf
  DEFAULT_VARIANT:=1
endef

define Package/pangolin-newt_nohf
  $(call Package/pangolin-newt/Default)
  DEPENDS+=@arm
  VARIANT:=nohf
endef

GO_LDFLAGS += -X 'main.newtVersion=$(PKG_VERSION)' -X 'main.newtPlatform=linux_$(GOARCH)'

define Package/pangolin-newt/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/newt $(1)/opt/bin/newt
endef

Package/pangolin-newt_nohf/install=$(Package/pangolin-newt/install)

$(eval $(call BuildPackage,pangolin-newt))
$(eval $(call BuildPackage,pangolin-newt_nohf))
