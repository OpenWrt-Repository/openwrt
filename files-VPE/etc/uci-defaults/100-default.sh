
mkdir -p /mnt/sda1

uci set system.@system[0].log_size='512'
uci set system.@system[0].zonename='Europe/Warsaw'
uci set system.@system[0].timezone='CET-1CEST,M3.5.0,M10.5.0/3'
uci commit system

rm /etc/ssl/certs/9168f543.0
rm /etc/ssl/certs/TÜRKTRUST_Elektronik_Sertifika_Hizmet_Sağlayıcısı_H5.crt
rm /etc/ssl/certs/7992b8bb.0
rm /etc/ssl/certs/451b5485.0
rm /etc/ssl/certs/a760e1bd.0
rm /etc/ssl/certs/Certplus_Root_CA_G1.crt
rm /etc/ssl/certs/Visa_eCommerce_Root.crt
rm /etc/ssl/certs/2c11d503.0
rm /etc/ssl/certs/Certplus_Root_CA_G2.crt
rm /etc/ssl/certs/OpenTrust_Root_CA_G1.crt
rm /etc/ssl/certs/OpenTrust_Root_CA_G2.crt
rm /etc/ssl/certs/608a55ad.0
rm /etc/ssl/certs/87229d21.0
rm /etc/ssl/certs/OpenTrust_Root_CA_G3.crt

chmod +x /etc/rc.local

uci set luci.ccache.enable=0
uci commit luci

uci del uhttpd.main.listen_https
uci set uhttpd.main.script_timeout='120'
uci set uhttpd.main.redirect_https='0'
uci set uhttpd.main.http_keepalive='0'
uci set uhttpd.main.max_requests='1'
uci set uhttpd.main.network_timeout='40'
uci commit uhttpd

uci set luci.sauth.sessiontime='360'
uci set luci.apply.rollback='60'
uci commit luci

chmod 4755 /usr/bin
chmod 4755 /usr/sbin

sed -i 's|Lede|EasyBOX|g' /lib/wifi/ralink.sh

cat << EOF >> /etc/profile
PS1='\e[1;31m\u@\h: \e[31m\W\e[0m\$ '
EOF

chmod -R 777 /mnt/sda1

uci set system.ntp.enabled=1
uci commit system

chmod +x /usr/share/3ginfo/cgi-bin/3ginfo.sh

ln -s /etc/init.d/wpad /etc/init.d/hostapd
chmod +x /etc/init.d/smsled
chmod +x /sbin/smsled-init.sh
chmod 0400 /lib/firmware/voice_ar9_firmware.bin
chmod 0400 /lib/firmware/ifx_firmware.bin

chmod -R u=rwX,go= /etc/dropbear

uci set dhcp.@dnsmasq[0].dnsforwardmax='50'
uci commit dhcp

ln -s /usr/lib/libiwinfo.so.20210430 /usr/lib/libiwinfo.so

ln -s  /lib/functions/lantiq.sh /lib/functions/lantiq_dsl.sh

touch /var/etc/timecontrol.include

chmod +x /usr/bin/watchdog2cron.sh
chmod +x /usr/bin/lite-watchdog-data.sh
chmod +x /usr/bin/lite_watchdog.sh
chmod +x /sbin/cronsync.sh
chmod +x /sbin/set_sms_ports.sh
chmod +x /sbin/smsled-init.sh
chmod +x /sbin/smsled.sh

uci set adblock.global=adblock
uci set adblock.global.adb_enabled='1'
uci set adblock.global.adb_debug='0'
uci set adblock.global.adb_safesearch='0'
uci set adblock.global.adb_dnsfilereset='0'
uci set adblock.global.adb_mail='0'
uci set adblock.global.adb_report='0'
uci set adblock.global.adb_backup='1'
uci set adblock.global.adb_trigger='wan'
uci set adblock.global.adb_nice='10'
uci set adblock.global.adb_forcesrt='0'
uci set adblock.global.adb_forcedns='1'
uci set adblock.global.adb_dnsflush='1'
uci set adblock.global.adb_maxqueue='8'
uci set adblock.global.adb_triggerdelay='60'
uci set adblock.global.adb_dns='dnsmasq'
uci set adblock.global.adb_fetchutil='wget'
uci set adblock.global.adb_sources=''adaway' 'android_tracking' 'disconnect' 'reg_pl1' 'reg_pl2' 'wally3k' 'winhelp' 'winspy' 'yoyo''
uci commit adblock

#usermod -aG audio,dialout asterisk
#usermod -aG audio,dialout root

chmod 600 /etc/lcd4linux.conf