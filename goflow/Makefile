# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=goflow
PKG_VERSION:=3.4.5
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2022-08-29
PKG_SOURCE_VERSION:=742cddc5dc37bac910151b9519e2720776ba404d
PKG_SOURCE_URL:=https://github.com/cloudflare/goflow
PKG_MIRROR_HASH:=643c329ec72b86b4ab26dfb1e467d9e464a6206f29212153dc73397a8d143757

PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE.txt

PKG_BUILD_PARALLEL:=1

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
  DEPENDS:=@arm
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
  DEPENDS:=@arm
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
  DEPENDS:=@arm
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
  DEPENDS:=@arm
endef

define Package/goflow/description
  The high-scalability sFlow/NetFlow/IPFIX collector used
  internally at Cloudflare.
  (full)
endef

Package/goflow_nohf/description=$(Package/goflow/description)

GO_LDFLAGS += \
	-X 'main.version=$(PKG_VERSION)' \
	-X 'main.buildinfos=$(PKG_SOURCE_DATE)'

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
