#
# Copyright (C) 2023 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=goflow
PKG_VERSION:=3.4.4
PKG_RELEASE:=1
SOURCE_DATE:=2022-07-25

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=c829ccd2c0aafdc9b886b20bf6f28095607f4998
PKG_SOURCE_URL:=https://github.com/cloudflare/goflow
PKG_MIRROR_HASH:=35660f2611012f7fde78d6160cf51645b9cf8aac3f10731ea92d49f1ae8db640

PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE.txt

include ../goenv.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/goflow/Default
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=prometheus tools
  TITLE:=a NetFlow/IPFIX/sFlow collector
  URL:=https://github.com/cloudflare/goflow
  MAINTAINER:=Entware team, https://entware.net
  CONFLICTS:=netflow-exporter
endef

define Package/cnetflow
  $(call Package/goflow/Default)
  TITLE+=(IPFIX/NetFlow v9)
  VARIANT:=hf
endef

define Package/cnetflow_nohf
  $(call Package/goflow/Default)
  TITLE+=(IPFIX/NetFlow v9)
  VARIANT:=nohf
  DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/cnetflow/description
  The high-scalability sFlow/NetFlow/IPFIX collector used
  internally at Cloudflare.
  (IPFIX/NetFlow v9)
endef

Package/cnetflow_nohf/description=$(Package/cnetflow/description)

define Package/cnflegacy
  $(call Package/goflow/Default)
  TITLE+=(NetFlow v5)
  VARIANT:=hf
endef

define Package/cnflegacy_nohf
  $(call Package/goflow/Default)
  TITLE+=(NetFlow v5)
  VARIANT:=nohf
  DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/cnflegacy/description
  The high-scalability sFlow/NetFlow/IPFIX collector used
  internally at Cloudflare.
  (NetFlow v5)
endef

Package/cnflegacy_nohf/description=$(Package/cnflegacy/description)

define Package/csflow
  $(call Package/goflow/Default)
  TITLE+=(sFlow v5)
  VARIANT:=hf
endef

define Package/csflow_nohf
  $(call Package/goflow/Default)
  TITLE+=(sFlow v5)
  VARIANT:=nohf
  DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/csflow/description
  The high-scalability sFlow/NetFlow/IPFIX collector used
  internally at Cloudflare.
  (sFlow v5)
endef

Package/csflow_nohf/description=$(Package/csflow/description)

define Package/goflow
  $(call Package/goflow/Default)
  TITLE+=(full)
  VARIANT:=hf
endef

define Package/goflow_nohf
  $(call Package/goflow/Default)
  TITLE+=(full)
  VARIANT:=nohf
  DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/goflow/description
  The high-scalability sFlow/NetFlow/IPFIX collector used
  internally at Cloudflare.
  (full)
endef

Package/goflow_nohf/description=$(Package/goflow/description)

GO_LDFLAGS += \
	-X 'main.version=$(PKG_VERSION)' \
	-X 'main.buildinfos=$(SOURCE_DATE)'

GO_TARGET:=./cmd/...

define Package/cnetflow/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/cnetflow $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S99cnetflow $(1)/opt/etc/init.d
endef

Package/cnetflow_nohf/install=$(Package/cnetflow/install)

define Package/cnflegacy/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/cnflegacy $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S99cnflegacy $(1)/opt/etc/init.d
endef

Package/cnflegacy_nohf/install=$(Package/cnflegacy/install)

define Package/csflow/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/csflow $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S99csflow $(1)/opt/etc/init.d
endef

Package/csflow_nohf/install=$(Package/csflow/install)

define Package/goflow/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/goflow $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S99goflow $(1)/opt/etc/init.d
endef

Package/goflow_nohf/install=$(Package/goflow/install)

$(eval $(call BuildPackage,cnetflow))
$(eval $(call BuildPackage,cnetflow_nohf))
$(eval $(call BuildPackage,cnflegacy))
$(eval $(call BuildPackage,cnflegacy_nohf))
$(eval $(call BuildPackage,csflow))
$(eval $(call BuildPackage,csflow_nohf))
$(eval $(call BuildPackage,goflow))
$(eval $(call BuildPackage,goflow_nohf))