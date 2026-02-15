# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2025-2026 Entware

# https://github.com/Entware/Entware/issues/1128

include $(TOPDIR)/rules.mk

PKG_NAME:=q
PKG_VERSION:=0.19.11
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2025-11-09
PKG_SOURCE_VERSION:=4b54702e6b56b48c8e9ee1f30d06e7aa487a9891
PKG_SOURCE_URL:=https://github.com/natesales/q
PKG_MIRROR_HASH:=a1193deb84eb85756efe5e379e0ff6e9e22045352902fb58c662957fbfff87a7

PKG_LICENSE:=GPL-3.0-only
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/q/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  TITLE:=command line DNS client
  URL:=https://github.com/natesales/q
  PROVIDES:=q
endef

define Package/q
  $(call Package/q/Default)
  VARIANT:=hf
  DEFAULT_VARIANT:=1
endef

define Package/q_nohf
  $(call Package/q/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/q/description
  A tiny CLI DNS client library with support for UDP, TCP, DoT, DoH,
 and DoQ.
endef

Package/q_nohf/description=$(Package/q/description)

GO_LDFLAGS += \
	-X 'main.version=$(PKG_VERSION)' \
	-X 'main.commit=$(COMMIT_SHORT)' \
	-X 'main.date=$(PKG_SOURCE_DATE)'

define Package/q/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/q $(1)/opt/sbin
endef

Package/q_nohf/install=$(Package/q/install)

$(eval $(call BuildPackage,q))
$(eval $(call BuildPackage,q_nohf))
