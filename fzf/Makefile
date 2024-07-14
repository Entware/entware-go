# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=fzf
PKG_VERSION:=0.54.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=9e92b6f11e0f59272de410f56493893334071e6e
PKG_SOURCE_URL:=https://github.com/junegunn/fzf
PKG_MIRROR_HASH:=49ad47aea73749e6e9091bd3e1ce2867c2c72406388d553524cf17be6dc14fe6

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/fzf/Default
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=A command-line fuzzy finder
  URL:=https://github.com/junegunn/fzf
endef

define Package/fzf
  $(call Package/fzf/Default)
  VARIANT:=hf
endef

define Package/fzf_nohf
  $(call Package/fzf/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/fzf/description
  fzf is a general-purpose command-line fuzzy finder.
endef

Package/fzf_nohf/description=$(Package/fzf/description)

GO_LDFLAGS += \
	-X 'main.version=$(PKG_VERSION)' \
	-X 'main.revision=$(COMMIT_SHORT)'

define Package/fzf/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/fzf $(1)/opt/sbin
endef

Package/fzf_nohf/install=$(Package/fzf/install)

$(eval $(call BuildPackage,fzf))
$(eval $(call BuildPackage,fzf_nohf))
