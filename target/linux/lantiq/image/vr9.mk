DEVICE_VARS += NETGEAR_BOARD_ID NETGEAR_HW_ID

define Device/alphanetworks_asl56026
  DEVICE_VENDOR := Alpha
  DEVICE_MODEL := ASL56026
  DEVICE_ALT0_VENDOR := BT Openreach
  DEVICE_ALT0_MODEL := ECI VDSL Modem V-2FUb/I
  IMAGE_SIZE := 7488k
  DEVICE_PACKAGES := dsl-vrx200-firmware-xdsl-a dsl-vrx200-firmware-xdsl-b-patch
endef
TARGET_DEVICES += alphanetworks_asl56026

define Device/arcadyan_arv7519rw22
  DEVICE_VENDOR := Arcadyan
  DEVICE_MODEL := ARV7519RW22
  DEVICE_ALT0_VENDOR := Orange
  DEVICE_ALT0_MODEL := Livebox
  DEVICE_ALT0_VARIANT := 2.1
  DEVICE_ALT1_VENDOR := Astoria Networks
  DEVICE_ALT1_MODEL := ARV7519RW22
  KERNEL_SIZE := 2048k
  IMAGE_SIZE := 31232k
  DEVICE_PACKAGES := kmod-usb-dwc2 dsl-vrx200-firmware-xdsl-a dsl-vrx200-firmware-xdsl-b-patch
  SUPPORTED_DEVICES += ARV7519RW22
  DEFAULT := n
endef
TARGET_DEVICES += arcadyan_arv7519rw22

define Device/arcadyan_vg3503j
  DEVICE_VENDOR := BT Openreach
  DEVICE_MODEL := ECI VDSL Modem V-2FUb/R
  IMAGE_SIZE := 8000k
  SUPPORTED_DEVICES += VG3503J
endef
TARGET_DEVICES += arcadyan_vg3503j

define Device/arcadyan_vgv7510kw22-brn
  $(Device/lantiqBrnImage)
  DEVICE_VENDOR := Arcadyan
  DEVICE_MODEL := VGV7510KW22
  DEVICE_VARIANT := BRN
  DEVICE_ALT0_VENDOR := o2
  DEVICE_ALT0_MODEL := Box 6431
  DEVICE_ALT0_VARIANT := BRN
  IMAGE_SIZE := 7168k
  SIGNATURE := BRNDA6431
  MAGIC := 0x12345678
  CRC32_POLY := 0x04c11db7
  DEVICE_PACKAGES := kmod-rt2800-pci wpad-basic-wolfssl kmod-usb-dwc2 kmod-ltq-tapi kmod-ltq-vmmc dsl-vrx200-firmware-xdsl-a dsl-vrx200-firmware-xdsl-b-patch
  SUPPORTED_DEVICES += VGV7510KW22BRN
endef
TARGET_DEVICES += arcadyan_vgv7510kw22-brn

define Device/arcadyan_vgv7510kw22-nor
  DEVICE_VENDOR := Arcadyan
  DEVICE_MODEL := VGV7510KW22
  DEVICE_ALT0_VENDOR := o2
  DEVICE_ALT0_MODEL := Box 6431
  IMAGE_SIZE := 15232k
endef

define Device/arcadyan_vgv7510kw22-nor-smp
$(Device/arcadyan_vgv7510kw22-nor)
  DEVICE_VARIANT := NOR-SMP
  DEVICE_ALT0_VARIANT := NOR-SMP
  DEVICE_PACKAGES := kmod-rt2800-pci wpad-basic-wolfssl kmod-usb-dwc2 dsl-vrx200-firmware-xdsl-a dsl-vrx200-firmware-xdsl-b-patch
endef
TARGET_DEVICES += arcadyan_vgv7510kw22-nor-smp

define Device/arcadyan_vgv7510kw22-nor-vpe
$(Device/arcadyan_vgv7510kw22-nor)
  DEVICE_VARIANT := NOR-VPE
  DEVICE_ALT0_VARIANT := NOR-VPE
  DEVICE_PACKAGES := kmod-rt2800-pci wpad-basic-wolfssl kmod-usb-dwc2 kmod-ltq-tapi kmod-ltq-vmmc dsl-vrx200-firmware-xdsl-a dsl-vrx200-firmware-xdsl-b-patch
endef
TARGET_DEVICES += arcadyan_vgv7510kw22-nor-vpe

define Device/arcadyan_vgv7510kw22phy11g-nor
  DEVICE_VENDOR := Arcadyan
  DEVICE_MODEL := VGV7510KW22
  DEVICE_ALT0_VENDOR := o2
  DEVICE_ALT0_MODEL := Box 6431
  IMAGE_SIZE := 15232k
endef

define Device/arcadyan_vgv7510kw22phy11g-nor-smp
$(Device/arcadyan_vgv7510kw22phy11g-nor)
  DEVICE_VARIANT := PHY11G-NOR-SMP
  DEVICE_ALT0_VARIANT := PHY11G-NOR-SMP
  DEVICE_PACKAGES := kmod-rt2800-pci wpad-basic-wolfssl kmod-usb-dwc2 dsl-vrx200-firmware-xdsl-a dsl-vrx200-firmware-xdsl-b-patch
endef
TARGET_DEVICES += arcadyan_vgv7510kw22phy11g-nor-smp

define Device/arcadyan_vgv7510kw22phy11g-nor-vpe
$(Device/arcadyan_vgv7510kw22phy11g-nor)
  DEVICE_VARIANT := PHY11G-NOR-VPE
  DEVICE_ALT0_VARIANT := PHY11G-NOR-VPE
  DEVICE_PACKAGES := kmod-rt2800-pci wpad-basic-wolfssl kmod-usb-dwc2 kmod-ltq-tapi kmod-ltq-vmmc dsl-vrx200-firmware-xdsl-a dsl-vrx200-firmware-xdsl-b-patch
endef
TARGET_DEVICES += arcadyan_vgv7510kw22phy11g-nor-vpe

define Device/arcadyan_vgv7519-brn
  $(Device/lantiqBrnImage)
  DEVICE_VENDOR := Arcadyan
  DEVICE_MODEL := VGV7519
  DEVICE_VARIANT := BRN
  DEVICE_ALT0_VENDOR := KPN
  DEVICE_ALT0_MODEL := Experiabox 8
  DEVICE_ALT0_VARIANT := BRN
  IMAGE_SIZE := 7168k
  SIGNATURE := 5D00008000
  MAGIC := 0x12345678
  CRC32_POLY := 0x2083b8ed
  DEVICE_PACKAGES := kmod-rt2800-pci wpad-basic-wolfssl kmod-usb-dwc2 kmod-ltq-tapi kmod-ltq-vmmc dsl-vrx200-firmware-xdsl-a dsl-vrx200-firmware-xdsl-b-patch
  SUPPORTED_DEVICES += VGV7519BRN
endef
TARGET_DEVICES += arcadyan_vgv7519-brn

define Device/arcadyan_vgv7519-nor
  DEVICE_VENDOR := Arcadyan
  DEVICE_MODEL := VGV7519
  DEVICE_VARIANT := NOR
  DEVICE_ALT0_VENDOR := KPN
  DEVICE_ALT0_MODEL := Experiabox 8
  DEVICE_ALT0_VARIANT := NOR
  IMAGE_SIZE := 15360k
  DEVICE_PACKAGES := kmod-rt2800-pci wpad-basic-wolfssl kmod-usb-dwc2 kmod-ltq-tapi kmod-ltq-vmmc dsl-vrx200-firmware-xdsl-a dsl-vrx200-firmware-xdsl-b-patch
  SUPPORTED_DEVICES += VGV7519NOR
endef
TARGET_DEVICES += arcadyan_vgv7519-nor

define Device/arcadyan_vgv952cjw33-e-ir
  $(Device/NAND)
  DEVICE_VENDOR := Arcadyan
  DEVICE_MODEL := VGV952CJW33-E-IR
  DEVICE_ALT0_VENDOR := Vodafone
  DEVICE_ALT0_MODEL := Easybox 904xDSL
  SUPPORTED_DEVICES += VGV952CJW33-E-IR
  IMAGES := sysupgrade.bin
  KERNEL_INITRAMFS := kernel-bin | append-dtb | lzma | uImage lzma | pad-offset 16 0 | append-uImage-dummyrootfs | append-metadata
endef

define Device/arcadyan_vgv952cjw33-e-ir-vpe
  $(Device/arcadyan_vgv952cjw33-e-ir)
  DEVICE_VARIANT := VPE
  DEVICE_ALT0_VARIANT := vpe
  DEVICE_PACKAGES := kmod-usb-dwc2 kmod-ltq-tapi kmod-ltq-vmmc wpad-basic-wolfssl
  SUPPORTED_DEVICES += VGV952CJW33-E-IR
endef
TARGET_DEVICES += arcadyan_vgv952cjw33-e-ir-vpe

define Device/arcadyan_vgv952cjw33-e-ir-smp
  $(Device/arcadyan_vgv952cjw33-e-ir)
  DEVICE_VARIANT := SMP
  DEVICE_ALT0_VARIANT := smp
  DEVICE_PACKAGES := kmod-usb-dwc2 wpad-basic-wolfssl
  SUPPORTED_DEVICES += VGV952CJW33-E-IR
endef
TARGET_DEVICES += arcadyan_vgv952cjw33-e-ir-smp

define Device/arcadyan_vgv953akw22-b-23
  $(Device/NAND)
  DEVICE_VENDOR := Arcadyan
  DEVICE_MODEL := VGV953AKW22-B-23
  DEVICE_ALT0_VENDOR := Telekom
  DEVICE_ALT0_MODEL := Speedport W 921V
endef

define Device/arcadyan_vgv953akw22-b-23-smp
  $(Device/arcadyan_vgv953akw22-b-23)
  DEVICE_VARIANT := SMP
  DEVICE_ALT0_VARIANT := SMP
  DEVICE_PACKAGES := kmod-usb-dwc2 dsl-vrx200-firmware-xdsl-a dsl-vrx200-firmware-xdsl-b-patch
endef
TARGET_DEVICES += arcadyan_vgv953akw22-b-23-smp

define Device/arcadyan_vgv953akw22-b-23-vpe
  $(Device/arcadyan_vgv953akw22-b-23)
  DEVICE_VARIANT := VPE
  DEVICE_ALT0_VARIANT := VPE
  DEVICE_PACKAGES := kmod-usb-dwc2 kmod-ltq-tapi kmod-ltq-vmmc dsl-vrx200-firmware-xdsl-a dsl-vrx200-firmware-xdsl-b-patch
endef
TARGET_DEVICES += arcadyan_vgv953akw22-b-23-vpe

define Device/avm_fritz3370
  $(Device/AVM)
  $(Device/NAND)
  DEVICE_MODEL := FRITZ!Box 3370
  DEVICE_VARIANT := Rev. 2
  KERNEL_SIZE := 4096k
  UBINIZE_OPTS := -E 5
  IMAGES += eva-kernel.bin eva-filesystem.bin
  IMAGE/eva-kernel.bin := append-kernel
  IMAGE/eva-filesystem.bin := append-ubi
  DEVICE_PACKAGES := kmod-ath9k wpad-basic-wolfssl kmod-usb-dwc2 fritz-tffs dsl-vrx200-firmware-xdsl-a dsl-vrx200-firmware-xdsl-b-patch
endef

define Device/avm_fritz3370-rev2-hynix
  $(Device/avm_fritz3370)
  DEVICE_MODEL := FRITZ!Box 3370
  DEVICE_VARIANT := Rev. 2 (Hynix NAND)
endef
TARGET_DEVICES += avm_fritz3370-rev2-hynix

define Device/avm_fritz3370-rev2-micron
  $(Device/avm_fritz3370)
  DEVICE_MODEL := FRITZ!Box 3370
  DEVICE_VARIANT := Rev. 2 (Micron NAND)
endef
TARGET_DEVICES += avm_fritz3370-rev2-micron

define Device/avm_fritz7360sl
  $(Device/AVM)
  DEVICE_MODEL := FRITZ!Box 7360 SL
  IMAGE_SIZE := 15744k
  DEVICE_PACKAGES := kmod-ath9k kmod-owl-loader wpad-basic-wolfssl kmod-usb-dwc2 dsl-vrx200-firmware-xdsl-a dsl-vrx200-firmware-xdsl-b-patch
  SUPPORTED_DEVICES += FRITZ7360SL
endef
TARGET_DEVICES += avm_fritz7360sl

define Device/avm_fritz7360-v2
  $(Device/AVM)
  DEVICE_MODEL := FRITZ!Box 7360
  DEVICE_VARIANT := v2
  IMAGE_SIZE := 32128k
  DEVICE_PACKAGES := kmod-ath9k kmod-owl-loader wpad-basic-wolfssl kmod-usb-dwc2 dsl-vrx200-firmware-xdsl-a dsl-vrx200-firmware-xdsl-b-patch
endef
TARGET_DEVICES += avm_fritz7360-v2

define Device/avm_fritz7362sl
  $(Device/AVM)
  $(Device/NAND)
  DEVICE_MODEL := FRITZ!Box 7362 SL
  KERNEL_SIZE := 4096k
  IMAGE_SIZE := 49152k
  DEVICE_PACKAGES := kmod-ath9k kmod-owl-loader wpad-basic-wolfssl kmod-usb-dwc2 fritz-tffs dsl-vrx200-firmware-xdsl-a dsl-vrx200-firmware-xdsl-b-patch
endef
TARGET_DEVICES += avm_fritz7362sl

define Device/avm_fritz7412
  $(Device/AVM)
  $(Device/NAND)
  DEVICE_MODEL := FRITZ!Box 7412
  BOARD_NAME := FRITZ7412
  KERNEL_SIZE := 4096k
  IMAGE_SIZE := 49152k
  DEVICE_PACKAGES := kmod-ath9k kmod-owl-loader wpad-basic-wolfssl fritz-tffs-nand fritz-caldata dsl-vrx200-firmware-xdsl-a dsl-vrx200-firmware-xdsl-b-patch
endef
TARGET_DEVICES += avm_fritz7412

define Device/avm_fritz7430
  $(Device/AVM)
  $(Device/NAND)
  DEVICE_MODEL := FRITZ!Box 7430
  KERNEL_SIZE := 4096k
  IMAGE_SIZE := 49152k
  DEVICE_PACKAGES := kmod-ath9k kmod-owl-loader wpad-basic-wolfssl fritz-tffs-nand fritz-caldata dsl-vrx200-firmware-xdsl-a dsl-vrx200-firmware-xdsl-b-patch
endef
TARGET_DEVICES += avm_fritz7430

define Device/bt_homehub-v5a
  $(Device/NAND)
  DEVICE_VENDOR := British Telecom
  DEVICE_MODEL := Home Hub 5
  DEVICE_VARIANT := Type A
  BOARD_NAME := BTHOMEHUBV5A
  DEVICE_PACKAGES := kmod-ath9k kmod-owl-loader \
	kmod-ath10k-ct ath10k-firmware-qca988x-ct wpad-basic-wolfssl kmod-usb-dwc2 dsl-vrx200-firmware-xdsl-a dsl-vrx200-firmware-xdsl-b-patch
  SUPPORTED_DEVICES += BTHOMEHUBV5A
endef
TARGET_DEVICES += bt_homehub-v5a

define Device/buffalo_wbmr-300hpd
  DEVICE_VENDOR := Buffalo
  DEVICE_MODEL := WBMR-300HPD
  IMAGE_SIZE := 15616k
  DEVICE_PACKAGES := kmod-mt7603 wpad-basic-wolfssl kmod-usb-dwc2 dsl-vrx200-firmware-xdsl-a dsl-vrx200-firmware-xdsl-b-patch
  SUPPORTED_DEVICES += WBMR300
endef
TARGET_DEVICES += buffalo_wbmr-300hpd

define Device/lantiq_easy80920-nand
  $(Device/lantiqFullImage)
  DEVICE_VENDOR := Lantiq
  DEVICE_MODEL := VR9 EASY80920
  DEVICE_VARIANT := NAND
  IMAGE_SIZE := 64512k
  DEVICE_PACKAGES := kmod-ath9k kmod-owl-loader wpad-basic-wolfssl kmod-usb-dwc2 kmod-usb-ledtrig-usbport dsl-vrx200-firmware-xdsl-a dsl-vrx200-firmware-xdsl-b-patch
endef
TARGET_DEVICES += lantiq_easy80920-nand

define Device/lantiq_easy80920-nor
  DEVICE_VENDOR := Lantiq
  DEVICE_MODEL := VR9 EASY80920
  DEVICE_VARIANT := NOR
  IMAGE_SIZE := 7936k
  DEVICE_PACKAGES := kmod-ath9k kmod-owl-loader wpad-basic-wolfssl kmod-usb-dwc2 kmod-usb-ledtrig-usbport dsl-vrx200-firmware-xdsl-a dsl-vrx200-firmware-xdsl-b-patch
endef
TARGET_DEVICES += lantiq_easy80920-nor

define Device/netgear_dm200
  DEVICE_VENDOR := NETGEAR
  DEVICE_MODEL := DM200
  IMAGES := sysupgrade.bin factory.img
  IMAGE/sysupgrade.bin := append-kernel | \
	pad-offset 64k 64 | append-uImage-fakehdr filesystem | \
	pad-offset 64k 64 | append-uImage-fakehdr filesystem | \
	append-rootfs | pad-rootfs | append-metadata | check-size
  IMAGE/factory.img := $$(IMAGE/sysupgrade.bin) | netgear-dni
  IMAGE_SIZE := 7872k
  NETGEAR_BOARD_ID := DM200
  NETGEAR_HW_ID := 29765233+8+0+64+0+0
  DEVICE_PACKAGES := dsl-vrx200-firmware-xdsl-a dsl-vrx200-firmware-xdsl-b-patch
endef
TARGET_DEVICES += netgear_dm200

define Device/zyxel_p-2812hnu-f1
  $(Device/NAND)
  DEVICE_VENDOR := ZyXEL
  DEVICE_MODEL := P-2812HNU
  DEVICE_VARIANT := F1
  BOARD_NAME := P2812HNUF1
  DEVICE_PACKAGES := kmod-rt2800-pci wpad-basic-wolfssl kmod-usb-dwc2 kmod-usb-ledtrig-usbport dsl-vrx200-firmware-xdsl-a dsl-vrx200-firmware-xdsl-b-patch
  KERNEL_SIZE := 3072k
  SUPPORTED_DEVICES += P2812HNUF1
endef
TARGET_DEVICES += zyxel_p-2812hnu-f1

define Device/zyxel_p-2812hnu-f3
  $(Device/NAND)
  DEVICE_VENDOR := ZyXEL
  DEVICE_MODEL := P-2812HNU
  DEVICE_VARIANT := F3
  BOARD_NAME := P2812HNUF3
  DEVICE_PACKAGES := kmod-rt2800-pci wpad-basic-wolfssl kmod-usb-dwc2 dsl-vrx200-firmware-xdsl-a dsl-vrx200-firmware-xdsl-b-patch
  KERNEL_SIZE := 2048k
  SUPPORTED_DEVICES += P2812HNUF3
  DEFAULT := n
endef
TARGET_DEVICES += zyxel_p-2812hnu-f3
