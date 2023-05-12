## OpenWrt 21.02.7 with support for Arcadyan/Astoria Easybox 904 xDSL (VGV952CJW33-E-IR)

### Requirements

You need the following tools to compile OpenWrt, the package names vary between
distributions. A complete list with distribution specific packages is found in
the [Build System Setup](https://openwrt.org/docs/guide-developer/build-system/install-buildsystem)
documentation.

```
gcc binutils bzip2 flex python3 perl make find grep diff unzip gawk getopt
subversion libz-dev libc-dev rsync which
```

### Quickstart

1. Run `./scripts/feeds update -a` to obtain all the latest package definitions
   defined in feeds.conf / feeds.conf.default

2. Run `./scripts/feeds install -f` and `./scripts/feeds install -a` to install symlinks for all obtained
   packages into package/feeds/

3. Copy config file `cp .config-VPE .config` or `cp .config-SMP .config`

4. Copy the contents of directory `files-VPE` or `files-SMP` to directory `files`

5. Run `make menuconfig` to select your preferred configuration for the
   toolchain, target system & firmware packages.

6. Run `make` to build your firmware. 
   
### Other

* [Firmware Recovery with GUI](https://github.com/zuzia-dev/Easybox-904xDSL)
* [Repository of compiled images and packages](https://github.com/zuzia-dev/Easybox-904xDSL-repo-source)
* [Full source with feeds](https://github.com/zuzia-dev/Easybox-904xDSL-repo-source/raw/main/Source/Easybox-904xDSL-full-source-openwrt-21.02-v2.zip): Zip file, 523 MB.
* [The official OpenWrt forum](https://forum.openwrt.org/t/lantiq-xrx200-easybox-904xdsl-and-speedport-w-921v-build/77105)

## License

OpenWrt is licensed under GPL-2.0
> It based on https://github.com/Plonkbong/openwrt/tree/xrx200-21.02.2

