# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=meek
PKG_VERSION:=0.38.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_URL:=https://gitlab.torproject.org/tpo/anti-censorship/pluggable-transports/meek
PKG_MIRROR_HASH:=fb491b37afdb56fb7f657b7434775945c64bba84cd0ff13fa95f659546ecb0f7

PKG_LICENSE:=CC0-1.0
PKG_LICENSE_FILES:=COPYING
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/meek/Default
  SECTION:=net
  CATEGORY:=Network
  TITLE:=a blocking-resistant pluggable transport (HTTPS transport)
  URL:=https://gitlab.torproject.org/tpo/anti-censorship/pluggable-transports/meek
endef

define Package/meek-client
  $(call Package/meek/Default)
  VARIANT:=hf
endef

define Package/meek-client_nohf
  $(call Package/meek/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/meek-server
  $(call Package/meek/Default)
  VARIANT:=hf
endef

define Package/meek-server_nohf
  $(call Package/meek/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/meek/description
  meek is a blocking-resistant pluggable transport for Tor.
  It encodes a data stream as a sequence of HTTPS requests and responses.
  Requests are reflected through a hard-to-block third-party web server in
  order to avoid talking directly to a Tor bridge. HTTPS encryption hides
  fingerprintable byte patterns in Tor traffic.
endef

Package/meek-client/description=$(Package/meek/description)
Package/meek-client_nohf/description=$(Package/meek/description)
Package/meek-server/description=$(Package/meek/description)
Package/meek-server_nohf/description=$(Package/meek/description)

GO_TARGET:=./meek-client ./meek-server

define Package/meek-client/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/meek-client $(1)/opt/sbin
endef

Package/meek-client_nohf/install=$(Package/meek-client/install)

define Package/meek-server/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/meek-server $(1)/opt/sbin
endef

Package/meek-server_nohf/install=$(Package/meek-server/install)

$(eval $(call BuildPackage,meek-client))
$(eval $(call BuildPackage,meek-client_nohf))
$(eval $(call BuildPackage,meek-server))
$(eval $(call BuildPackage,meek-server_nohf))
