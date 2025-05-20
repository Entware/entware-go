# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2025 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=micro
PKG_VERSION:=2.0.14
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2024-08-27
PKG_SOURCE_VERSION:=04c577049ca898f097cd6a2dae69af0b4d4493e1
PKG_SOURCE_URL:=https://github.com/zyedidia/micro
PKG_MIRROR_HASH:=df355d8a7a0d1496aedb78bb302f527437946fcf2efac850b48f82edf220973a

PKG_MAINTAINER:=Entware team, https://entware.net
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE LICENSE-THIRD-PARTY

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/micro/Default
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Editors
  TITLE:=a modern and intuitive terminal-based text editor
  URL:=https://micro-editor.github.io/
endef

define Package/micro
  $(call Package/micro/Default)
  VARIANT:=hf
endef

define Package/micro_nohf
  $(call Package/micro/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/micro/description
  micro is a terminal-based text editor that aims to be easy
  to use and intuitive, while also taking advantage of the capabilities of
  modern terminals.
endef

Package/micro_nohf/description=$(Package/micro/description)

GO_LDFLAGS += \
	-X '$(XIMPORTPATH)/v2/internal/util.Version=$(PKG_VERSION)' \
	-X '$(XIMPORTPATH)/v2/internal/util.CommitHash=$(COMMIT_SHORT)' \
	-X '$(XIMPORTPATH)/v2/internal/util.CompileDate=$(PKG_SOURCE_DATE)'

GO_TARGET:=./cmd/micro

define Build/Compile
	( cd $(PKG_BUILD_DIR); $(GO_BIN_GENERATE) ./runtime; )
	$(call Build/Compile/Go)
endef

define Package/micro/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/micro $(1)/opt/sbin
endef

Package/micro_nohf/install=$(Package/micro/install)

$(eval $(call BuildPackage,micro))
$(eval $(call BuildPackage,micro_nohf))
