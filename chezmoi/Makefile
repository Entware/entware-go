#
# Copyright (C) 2023 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=chezmoi
PKG_VERSION:=2.34.0
PKG_RELEASE:=1
SOURCE_DATE:=2023-06-05

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=006230cc05fc1fe017c942758ee92aee3058d9c5
PKG_SOURCE_URL:=https://github.com/twpayne/chezmoi
PKG_MIRROR_HASH:=684c62d5b33bf3184a006d944a7845e097069a1f142fb8142d9ac2ac3c91e8dd

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

include ../goenv.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/chezmoi/Default
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=Manage dotfiles
	URL:=https://www.chezmoi.io
	MAINTAINER:=Entware team, https://entware.net
endef

define Package/chezmoi
	$(call Package/chezmoi/Default)
	VARIANT:=hf
endef

define Package/chezmoi_nohf
	$(call Package/chezmoi/Default)
	VARIANT:=nohf
	DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/chezmoi/description
  Manage your dotfiles across multiple diverse machines, securely.
endef

Package/chezmoi_nohf/description=$(Package/chezmoi/description)

GO_LDFLAGS += \
	-X 'main.version=v$(PKG_VERSION)' \
	-X 'main.commit=$(COMMIT_SHORT)' \
	-X 'main.date=$(SOURCE_DATE)' \
	-X 'main.builtBy=Entware'

GO_TAGS:=-tags=noupgrade

define Package/chezmoi/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/chezmoi $(1)/opt/bin
endef

Package/chezmoi_nohf/install=$(Package/chezmoi/install)

$(eval $(call BuildPackage,chezmoi))
$(eval $(call BuildPackage,chezmoi_nohf))
