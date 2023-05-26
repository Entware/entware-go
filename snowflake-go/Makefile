#
# Copyright (C) 2023 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=snowflake
PKG_VERSION:=2.5.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=7b77001eaa90e09d41172a2b170dabd3f1922b4a
PKG_SOURCE_URL:=https://git.torproject.org/pluggable-transports/snowflake
PKG_MIRROR_HASH:=7f36f48ab07ac9a3944202613b024072f3ad0ad55b495fde611ee30223410fdf

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
GO_TARGET:=./broker ./client ./distinctcounter ./probetest ./proxy ./server

BINS:=broker client distinctcounter probetest proxy server

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
