#
# Copyright (C) 2011-2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=obfs4
PKG_VERSION:=0.0.14
PKG_RELEASE:=1

PKG_GOGET:=gitlab.com/yawning/obfs4

PKG_SOURCE_VERSION:=336a71d6e4cfd2d33e9c57797828007ad74975e9

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://$(PKG_GOGET)
PKG_MIRROR_HASH:=c3aa598023543ea18cde3fa0addf11a237b42cbb708645c6f282ec399cdf80ab

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/obfs4/Default
	SECTION:=net
	CATEGORY:=Network
	TITLE:=A Tor pluggable transport proxy, implementing obfs4
	URL:=https://gitlab.com/yawning/obfs4
	MAINTAINER:=Entware team, https://entware.net
	DEPENDS:=+tor
endef

define Package/obfs4
	$(call Package/obfs4/Default)
	VARIANT:=hf
endef

define Package/obfs4_nohf
	$(call Package/obfs4/Default)
	VARIANT:=nohf
	DEPENDS+=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/obfs4/description
obfs4proxy is a tool that attempts to circumvent censorship by
transforming the Tor traffic between the client and the bridge. This way
censors, who usually monitor traffic between the client and the bridge,
will see innocent-looking transformed traffic instead of the actual Tor
traffic.

obfs4proxy implements the obfsucation protocols obfs2, obfs3, and obfs4.

It is written in Go and is compliant with the Tor pluggable transports
specification, and its modular architecture allows it to support
multiple pluggable transports.
endef

Package/obfs4_nohf/description=$(Package/obfs4/description)

GO_TARGET:=./obfs4proxy

define Package/obfs4/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/obfs4proxy $(1)/opt/sbin
endef

Package/obfs4_nohf/install=$(Package/obfs4/install)

$(eval $(call BuildPackage,obfs4))
$(eval $(call BuildPackage,obfs4_nohf))
