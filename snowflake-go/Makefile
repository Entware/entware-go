# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=snowflake
PKG_VERSION:=2.9.2
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=05a95802c195b1d8a68bb6fe4fa98f12763af519
PKG_SOURCE_URL:=https://gitlab.torproject.org/tpo/anti-censorship/pluggable-transports/snowflake
PKG_MIRROR_HASH:=7b57423a1b326505999bbd3c96f60d3ef309399d5c16bb47755c39aed2deafbb

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/snowflake/Default
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Snowflake
	URL:=https://snowflake.torproject.org/
endef

define Package/snowflake-go
	$(call Package/snowflake/Default)
	VARIANT:=hf
endef

define Package/snowflake-go_nohf
	$(call Package/snowflake/Default)
	VARIANT:=nohf
	DEPENDS+=@arm
endef

define Package/snowflake-go/description
 Snowflake is a system that allows people from all over the world to
 access censored websites and applications. Similar to how VPNs assist
 users in getting around Internet censorship, Snowflake helps you avoid
 being noticed by Internet censors by making your Internet activity appear
 as though you're using the Internet for a regular video or voice call.
endef

Package/snowflake-go_hf/description=$(Package/snowflake-go/description)

GO_VARS += GO111MODULE=on
GO_TARGET:=./broker ./client ./probetest ./proxy ./server

BINS:=broker client probetest proxy server

define Package/snowflake-go/install
	$(INSTALL_DIR) $(1)/opt/bin
	for bin in $(BINS); do \
		$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/$$$$bin \
			$(1)/opt/bin/snowflake-$$$$bin; \
	done
	$(INSTALL_DIR) $(1)/opt/share/tor
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/broker/test_geoip \
		$(1)/opt/share/tor/geoip
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/broker/test_geoip6 \
		$(1)/opt/share/tor/geoip6
endef

$(eval $(call BuildPackage,snowflake-go))
$(eval $(call BuildPackage,snowflake-go_nohf))
