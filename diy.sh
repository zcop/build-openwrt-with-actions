#!/bin/bash
# Description: OpenWrt DIY script (CR881x Drivers + Your Customizations)

# --- PART 1: INJECT CR881x DRIVERS (New) ---
echo "Injecting CR881x/IPQ50xx Drivers from kmiit..."

# 1. Clone the community support (kmiit repo is best for ImmortalWrt + CR881x)
git clone https://github.com/kmiit/Redmi_AX3000_immortalwrt temp_drivers

# 2. Replace the official ipq50xx target with the community one
# This provides the necessary DTS and Kernel Config for your router
rm -rf target/linux/ipq50xx
cp -r temp_drivers/target/linux/ipq50xx target/linux/

# 3. Clean up
rm -rf temp_drivers


# --- PART 2: YOUR CUSTOM PACKAGES (Existing) ---
echo "Adding custom packages..."

# Add UA3F feed
echo 'src-git UA3F https://github.com/SunBK201/UA3F.git' >>feeds.conf.default

# Add AdGuardHome
git clone https://github.com/stevenjoezhang/luci-app-adguardhome.git package/ADGH


# --- PART 3: CONFIGURATION TWEAKS (Existing) ---
echo "Applying configuration tweaks..."

# Set LAN IP to 192.168.100.1 (Your preference)
sed -i 's/192.168.1.1/192.168.100.1/g' package/base-files/files/bin/config_generate

# Set default theme to Argon
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# (Optional) Rename firmware
# sed -i 's/OpenWrt/ZWRT/g' package/base-files/files/bin/config_generate
# sed -i 's/ImmortalWrt/ZWRT/g' package/base-files/files/bin/config_generate
