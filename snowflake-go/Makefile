# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=snowflake
PKG_VERSION:=2.9.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=38352b22ade217bd1372772b9cb69f8eff93e919
PKG_SOURCE_URL:=https://gitlab.torproject.org/tpo/anti-censorship/pluggable-transports/snowflake
PKG_MIRROR_HASH:=dd1f42b5161c701cd233436c19dacfd9d2fdd26a9baf22cc12f66479ee60f2cd

include ../goenv.mk
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
	DEPENDS+=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
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
