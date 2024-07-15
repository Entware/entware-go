# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=lyrebird
PKG_VERSION:=0.2.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=aab489105e97fdcf177327af73d84d35a80496c5
PKG_SOURCE_URL:=https://gitlab.torproject.org/tpo/anti-censorship/pluggable-transports/lyrebird
PKG_MIRROR_HASH:=a787d14ff7ac26952c69fb4caa08739edf53c889a6c35706f2101d025b57d141

PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE LICENSE-GPL3.txt
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/lyrebird/Default
  SECTION:=net
  CATEGORY:=Network
  TITLE:=pluggable transport proxy for Tor, implementing obfs4
  URL:=https://gitlab.torproject.org/tpo/anti-censorship/pluggable-transports/lyrebird
endef

define Package/lyrebird
  $(call Package/lyrebird/Default)
  VARIANT:=hf
endef

define Package/lyrebird_nohf
  $(call Package/lyrebird/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/lyrebird/description
  This is a look-like nothing obfuscation protocol that
  incorporates ideas and concepts from Philipp Winter's ScrambleSuit protocol.
  The obfs naming was chosen primarily because it was shorter, in terms of
  protocol ancestery obfs4 is much closer to ScrambleSuit than obfs2/obfs3.
endef

Package/lyrebird_nohf/description=$(Package/lyrebird/description)

GO_TARGET:=./cmd/lyrebird

define Package/lyrebird/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/lyrebird $(1)/opt/sbin
endef

Package/lyrebird_nohf/install=$(Package/lyrebird/install)

$(eval $(call BuildPackage,lyrebird))
$(eval $(call BuildPackage,lyrebird_nohf))
