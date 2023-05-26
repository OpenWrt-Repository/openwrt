append DRIVERS "ralink"

scan_ralink() {
	local device="$1"
	local vif vifs wds
	local apmode disabled
	local ap_if

	echo "scan device: $device"

	config_get vifs "$device" vifs
	for vif in $vifs; do
		
		config_get_bool disabled "$vif" disabled 0
		[ $disabled -eq 0 ] || continue

		local mode
		config_get mode "$vif" mode
		case "$mode" in
			ap)
				apmode=1
				ap_if="${ap_if:+$ap_if }$vif"
			;;
			wds)
				local addr
				config_get addr "$vif" bssid
				[ -z "$addr" ] || {
					addr=$(echo "$addr" | tr 'A-F' 'a-f')
					append wds "$addr"
				}
			;;
			*) echo "$device($vif): Invalid mode";;
		esac
	done
	config_set "$device" wds "$wds"

	#Only one vif supported on the master device
	local _c=0
#	for vif in ${ap_if}; do
#		config_set "$vif" ifname "${device}${_c:+-$_c}"
#		_c=$((${_c:-0} + 1))
#	done
	config_set "$vif" ifname "${device}"
	config_set "$device" vifs "${ap_if}"

	ap=0
	infra=0
	if [ "$_c" -gt 1 ]; then
		mssid=1
	else
		mssid=
	fi
	apsta=0
	radio=0
	monitor=0
	wet=0

#	case "$apmode" in
#		1*)
#			ap=1
#			mssid=
#			infra=0
#		;;
#		:1:1:)
#			apsta=1
#			wet=1
#		;;
#		:1::)
#			wet=1
#			ap=0
#			mssid=
#		;;
#		:::1)
#			wet=1
#			ap=0
#			mssid=
#			monitor=1
#		;;
#		::)
#			radio=0
#		;;
#	esac
}

disable_ralink() {
	local device="$1"
	set_wifi_down "$device"
	(
		include /lib/network

		local operstate
		# make sure the interfaces are down and removed from all bridges
		local dev ifname
		for dev in /sys/class/net/wds${device##wl}-* /sys/class/net/${device}-* /sys/class/net/${device}; do
			if [ -e "$dev" ]; then
				ifname=${dev##/sys/class/net/}
				operstate=`cat /sys/class/net/${ifname}/operstate`
				#echo "Shutdown $ifname State: $operstate"
				if [[ "$operstate" != "down" ]]; then
					echo "Shutdown interface $ifname"
					iwpriv $ifname set Enable=1
					iwpriv $ifname set Enable=0
					iwpriv $ifname set RadioOn=0
				fi
				#TODO: Avoid downing the main interfaces - only shut down secondary SSID devices
				#      It is sufficient to set it to Enable=0 and turn Radio off
				#Currently no device is shut down
				#ip link set dev "$ifname" down
				unbridge "$ifname"
			fi
		done
	)
	true
}
enable_ralink() {
	local device="$1"
	local channel country maxassoc wds vifs distance slottime rxantenna txantenna
	local frameburst macfilter maclist macaddr txpower frag rts hwmode htmode
	config_get channel "$device" channel
	config_get country "$device" country
	config_get maxassoc "$device" maxassoc
	config_get wds "$device" wds
	config_get vifs "$device" vifs
	config_get distance "$device" distance
	config_get rxantenna "$device" rxantenna
	config_get txantenna "$device" txantenna
	config_get_bool frameburst "$device" frameburst
	config_get macfilter "$device" macfilter
	config_get maclist "$device" maclist
	config_get macaddr "$device" macaddr #$(wlc ifname "$device" default_bssid)
	config_get txpower "$device" txpower
	config_get frag "$device" frag
	config_get rts "$device" rts
	config_get hwmode "$device" hwmode
	config_get htmode "$device" htmode
	local doth=0
	local wmm=1

	local _c=0
	local if_pre_up if_up
	local vif vif_pre_up vif_post_up vif_do_up vif_txpower
	local bssmax=4

	echo "Enable device $1"
	for vif in $vifs; do
		echo "DEVICE: $device VIF: $vif"
		local wsec_r=0
		local eap_r=0
		local wsec=0
		local auth=0
		local nasopts=
		local enc key rekey

		local ifname
		config_get ifname "$vif" ifname
		local if_cmd="if_pre_up"
		[ "$ifname" != "${ifname##${device}-}" ] && if_cmd="if_up"
		#append $if_cmd "macaddr=\$(wlc ifname '$ifname' cur_etheraddr)" ";$N"
		#append $if_cmd "ip link set dev '$ifname' address \$macaddr" ";$N"

		#Disable the interface; Enable it first, to avoid crashes on the dark side of the device
		append vif_post_up "iwpriv '$ifname' set Enable=1" ";$N"
		append vif_post_up "iwpriv '$ifname' set Enable=0" ";$N"
		append vif_post_up "iwpriv '$ifname' set RadioOn=0" ";$N"
		
		# Set a dummy encryption
		append vif_post_up "iwpriv '$ifname' set AuthMode=WEPAUTO" ";$N"
		append vif_post_up "iwpriv '$ifname' set EncrypType=WEP" ";$N"
		append vif_post_up "iwpriv '$ifname' set IEEE8021X=0" ";$N"
		
		config_get enc "$vif" encryption
		echo "Encryption: $enc"
		case "$enc" in
			*wep*)
				local def defkey k knr
				wsec_r=1
				wsec=1
				defkey=1
				config_get key "$vif" key
				case "$enc" in
					*shared*) append vif_do_up "wepauth 1" "$N";;
					*) append vif_do_up "wepauth 0" "$N";;
				esac
				case "$key" in
					[1234])
						defkey="$key"
						for knr in 1 2 3 4; do
							config_get k "$vif" key$knr
							[ -n "$k" ] || continue
							[ "$defkey" = "$knr" ] && def="=" || def=""
							append vif_do_up "wepkey $def$knr,$k" "$N"
						done
					;;
					"");;
					*) append vif_do_up "wepkey =1,$key" "$N";;
				esac
			;;
			*psk*)
				wsec_r=1
				config_get key "$vif" key
				case "$enc" in
					*psk)
						append vif_post_up "echo '$ifname' is WPA-TKIP MODE" "&&$N"
						append vif_post_up "iwpriv '$ifname' set AuthMode=WPAPSK" ";$N"
						append vif_post_up "iwpriv '$ifname' set EncrypType=TKIP" ";$N"
						append vif_post_up "iwpriv '$ifname' set IEEE8021X=0" ";$N"
						append vif_post_up "iwpriv '$ifname' set WPAPSK='$key'" ";$N"
						append vif_post_up "iwpriv '$ifname' set DefaultKeyID=2" ";$N"
						;;
					*psk2+aes)
						append vif_post_up "echo '$ifname' is WPA2-AES MODE" ";$N"
						append vif_post_up "iwpriv '$ifname' set AuthMode=WPA2PSK" ";$N"
						append vif_post_up "iwpriv '$ifname' set EncrypType=AES" ";$N"
						append vif_post_up "iwpriv '$ifname' set IEEE8021X=0" ";$N"
						append vif_post_up "iwpriv '$ifname' set WPAPSK='$key'" ";$N"
						append vif_post_up "iwpriv '$ifname' set DefaultKeyID=2" ";$N"
						;;
					*mixed+tkip+aes*)
						append vif_post_up "echo '$ifname' is WPA-MIX MODE" "&&$N"
						append vif_post_up "iwpriv '$ifname' set AuthMode=WPAPSKWPA2PSK" ";$N"
						append vif_post_up "iwpriv '$ifname' set EncrypType=TKIPAES" ";$N"
						append vif_post_up "iwpriv '$ifname' set IEEE8021X=0" ";$N"
						append vif_post_up "iwpriv '$ifname' set WPAPSK='$key'" ";$N"
						append vif_post_up "iwpriv '$ifname' set DefaultKeyID=2" ";$N"
						;;
					*)	echo "$enc - Not supported!"
						;;
				esac
			;;
		esac
		
		
		append if_up "ip link set dev '$ifname' up" ";$N"
		
		#append vif_pre_up "iwpriv '$ifname' set Enable=1 " ";$N"
		
		local ssid
		config_get ssid "$vif" ssid
		append vif_post_up "iwpriv '$ifname' set SSID=$ssid " ";$N"
		append vif_post_up "iwpriv '$ifname' set Channel=$channel " ";$N"
		
		append vif_post_up "iwpriv '$ifname' set Enable=1" ";$N"
		append vif_post_up "iwpriv '$ifname' set RadioOn=1 " ";$N"
		
		_c=$((${_c:-0} + 1))
	done

if [ $_c -eq 0 ]; then
	break
fi

echo "Preparing interface <$ifname>"
echo $if_pre_up
eval "$if_pre_up"

echo "Bring up interface <$ifname> to be able to send iwpriv commands"
eval $if_up

echo "Configure wifi device $ifname"
echo $vif_pre_up
eval "$vif_pre_up"

echo "Starting wifi device $ifname"
echo $vif_post_up
eval "$vif_post_up"
}

detect_ralink() {
	local i=-1

	while grep -qs "^ *wl0$((++i))0:" /proc/net/dev; do
		local channel type
		local iface=wl0${i}0
		config_get type ${iface} type
		[ "$type" = ralink ] && continue
		channel=auto
		echo "Setup interface ${iface}"
		uci -q batch <<-EOF
			set wireless.${iface}=wifi-device
			set wireless.${iface}.type=ralink
			set wireless.${iface}.channel=${channel:-11}
			set wireless.${iface}.disabled=1

			set wireless.default_${iface}=wifi-iface
			set wireless.default_${iface}.device=${iface}
			set wireless.default_${iface}.mode=ap
			set wireless.default_${iface}.ssid=Lede${i#0}
			set wireless.default_${iface}.encryption=psk2+aes
			set wireless.default_${iface}.key=WiFipassword
			set wireless.default_${iface}.network=lan
EOF

#set wireless.default_${iface}.network=lan
		uci -q commit wireless
		
		# Only respect the major interfaces 0|1
		if [ $i -eq 1 ]; then
			break
		fi
	done
}
