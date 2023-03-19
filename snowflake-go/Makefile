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

PKG_GOGET:=git.torproject.org/pluggable-transports/snowflake
PKG_SOURCE_VERSION:=7b77001eaa90e09d41172a2b170dabd3f1922b4a

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://$(PKG_GOGET)
PKG_MIRROR_HASH:=skip


include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/snowflake/Default
	TITLE:=Snowflake
	URL:=https://snowflake.torproject.org/
	SECTION:=net
	CATEGORY:=Network
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

define Package/snowflake-go/description/Default
 Snowflake is a system that allows people from all over the world to
 access censored websites and applications. Similar to how VPNs assist
 users in getting around Internet censorship, Snowflake helps you avoid
 being noticed by Internet censors by making your Internet activity appear
 as though you're using the Internet for a regular video or voice call.
endef

define Package/snowflake-go_hf/description=$(Package/snowflake/description/Default)
endef

GO_VARS += GO111MODULE=on
GO_TARGET:=./broker ./client ./distinctcounter ./probetest ./proxy ./server

define Package/snowflake-go_nohf/description
$(call Package/snowflake/description/Default)
endef

define Package/snowflake-go/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/* $(1)/opt/bin
endef

$(eval $(call BuildPackage,snowflake-go))
$(eval $(call BuildPackage,snowflake-go_nohf))
