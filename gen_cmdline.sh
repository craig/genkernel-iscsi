#!/bin/bash
# $Id$

longusage() {
  echo "Gentoo Linux Genkernel ${GK_V}"
  echo "Usage: "
  echo "  genkernel [options] action"
  echo
  echo "Available Actions: "
  echo "  all				Build all steps"
  echo "  bzImage			Build only the kernel"
  echo "  kernel			Build only the kernel and modules"
  echo "  ramdisk			Build only the ramdisk/initramfs"
  echo
  echo "Available Options: "
  echo "  Configuration settings"
  echo "	--config=<file>	genkernel configuration file to use"
  echo "  Debug settings"
  echo "	--loglevel=<0-5>	Debug Verbosity Level"
  echo "	--logfile=<outfile>	Output file for debug info"
  echo "	--color			Output debug in color"
  echo "	--no-color		Do not output debug in color"
  echo "  Kernel Configuration settings"
  echo "	--menuconfig		Run menuconfig after oldconfig"
  echo "	--no-menuconfig		Do not run menuconfig after oldconfig"
  echo "	--gconfig		Run gconfig after oldconfig"
  echo "	--xconfig		Run xconfig after oldconfig"
  echo "	--save-config		Save the configuration to /etc/kernels"
  echo "	--no-save-config	Don't save the configuration to /etc/kernels"
  echo "  Kernel Compile settings"
  echo "	--clean			Run make clean before compilation"
  echo "	--mrproper		Run make mrproper before compilation"
  echo "	--no-clean		Do not run make clean before compilation"
  echo "	--no-mrproper		Do not run make mrproper before compilation"
  echo "	--oldconfig		Implies --no-clean and runs a 'make oldconfig'"
  echo "	--gensplash		Install framebuffer splash support into initramfs"
  echo "	--splash		Install framebuffer splash support into initramfs"
  echo "	--no-splash		Do not install framebuffer splash"
  echo "	--install		Install the kernel after building"
  echo "	--no-install		Do not install the kernel after building"
  echo "	--symlink		Manage symlinks in /boot for installed images"
  echo "	--no-symlink		Do not manage symlinks"
  echo "	--no-ramdisk-modules	Don't copy any modules to the ramdisk"
  echo "	--all-ramdisk-modules	Copy all kernel modules to the ramdisk"
  echo "	--callback=<...>	Run the specified arguments after the"
  echo "				kernel and modules have been compiled"
  echo "	--static		Build a static (monolithic kernel)."
  echo "  Kernel settings"
  echo "	--kerneldir=<dir>	Location of the kernel sources"
  echo "	--kernel-config=<file>	Kernel configuration file to use for compilation"
  echo "	--module-prefix=<dir>	Prefix to kernel module destination, modules"
  echo "				will be installed in <prefix>/lib/modules"
  echo "  Low-Level Compile settings"
  echo "	--kernel-cc=<compiler>	Compiler to use for kernel (e.g. distcc)"
  echo "	--kernel-as=<assembler>	Assembler to use for kernel"
  echo "	--kernel-ld=<linker>	Linker to use for kernel"
  echo "	--kernel-cross-compile=<cross var> CROSS_COMPILE kernel variable"
  echo "	--kernel-make=<makeprg> GNU Make to use for kernel"
  echo "	--utils-cc=<compiler>	Compiler to use for utilities"
  echo "	--utils-as=<assembler>	Assembler to use for utils"
  echo "	--utils-ld=<linker>	Linker to use for utils"
  echo "	--utils-make=<makeprog>	GNU Make to use for utils"
  echo "	--utils-cross-compile=<cross var> CROSS_COMPILE utils variable"
  echo "	--utils-arch=<arch> 	Force to arch for utils only instead of"
  echo "				autodetect."
  echo "	--makeopts=<makeopts>	Make options such as -j2, etc..."
  echo "	--mountboot		Mount BOOTDIR automatically if mountable"
  echo "	--no-mountboot		Don't mount BOOTDIR automatically"  
  echo "	--bootdir=<dir>		Set the location of the boot-directory, default is /boot"
  echo "  Initialization"
  echo "	--gensplash=<theme>	Enable framebuffer splash using <theme>"
  echo "	--gensplash-res=<res>	Select splash theme resolutions to install"
  echo "	--splash=<theme>	Enable framebuffer splash using <theme>"
  echo "	--splash-res=<res>	Select splash theme resolutions to install"
  echo "	--do-keymap-auto	Forces keymap selection at boot"
  echo "	--no-keymap		Disables keymap selection support"
  echo "	--evms			Include EVMS support"
  echo "				--> 'emerge evms' in the host operating system"
  echo "				first"
  echo "	--evms2			Include EVMS support"
  echo "				--> 'emerge evms' in the host operating system"
  echo "				first"
  echo "	--lvm			Include LVM support"
  echo "	--lvm2			Include LVM support"
  echo "	--mdadm			Copy /etc/mdadm.conf to initramfs"
  echo "	--dmraid		Include DMRAID support"
  echo "	--multipath		Include Multipath support"
  echo "	--iscsi			Include iSCSI support"
  echo "	--slowusb		Enables extra pauses for slow USB CD boots"
  echo "	--bootloader=grub	Add new kernel to GRUB configuration"
  echo "	--linuxrc=<file>	Specifies a user created linuxrc"
  echo "	--busybox-config=<file>	Specifies a user created busybox config"
  echo "	--disklabel		Include disk label and uuid support in your"
  echo "				ramdisk"
  echo "	--luks			Include LUKS support"
  echo "				--> 'emerge cryptsetup-luks' with USE=-dynamic"
  echo "	--no-busybox    Do not include busybox in the initramfs."
  echo "	--unionfs       Include support for unionfs"
  echo "	--netboot       Create a self-contained env in the initramfs"
  echo "	--real-root=<foo> Specify a default for real_root="
  echo "  Internals"
  echo "	--arch-override=<arch>	Force to arch instead of autodetect"
  echo "	--cachedir=<dir>	Override the default cache location"
  echo "	--tempdir=<dir>		Location of Genkernel's temporary directory"
  echo "	--postclear		Clear all tmp files and caches after genkernel has run"
  echo "  Output Settings"
  echo "	--kernname=<...> 	Tag the kernel and ramdisk with a name:"
  echo "				If not defined the option defaults to"
  echo "				'genkernel'"
  echo "	--minkernpackage=<tbz2> File to output a .tar.bz2'd kernel and ramdisk:"
  echo "				No modules outside of the ramdisk will be"
  echo "				included..."
  echo "	--modulespackage=<tbz2> File to output a .tar.bz2'd modules after the"
  echo "				callbacks have run"
  echo "	--kerncache=<tbz2> 	File to output a .tar.bz2'd kernel contents"
  echo "				of /lib/modules/ and the kernel config"
  echo "				NOTE: This is created before the callbacks"
  echo "				are run!"
  echo "	--no-kernel-sources	This option is only valid if kerncache is"
  echo "				defined. If there is a valid kerncache no checks"
  echo "				will be made against a kernel source tree"
  echo "	--initramfs-overlay=<dir>"
  echo "				Directory structure to include in the initramfs,"
  echo "				only available on 2.6 kernels"
  echo "	--firmware"
  echo "				Enable copying of firmware into initramfs"
  echo "	--firmware-dir=<dir>"
  echo "				Specify directory to copy firmware from (defaults"
  echo "				to /lib/firmware)"
  echo "	--firmware-files=<files>"
  echo "				Specifies specific firmware files to copy. This"
  echo "				overrides --firmware-dir. For multiple files,"
  echo "				separate the filenames with a comma"
  echo "	--integrated-initramfs"
  echo "				Build the generated initramfs into the kernel instead of"
  echo "				keeping it as a separate file"
}

usage() {
  echo "Gentoo Linux Genkernel ${GK_V}"
  echo "Usage: "
  echo "	genkernel [options] all"
  echo
  echo 'Some useful options:'
  echo '	--menuconfig		Run menuconfig after oldconfig'
  echo '	--no-clean		Do not run make clean before compilation'
  echo '	--no-mrproper		Do not run make mrproper before compilation,'
  echo '				this is implied by --no-clean.'
  echo
  echo 'For a detailed list of supported options and flags; issue:'
  echo '	genkernel --help'
}

parse_cmdline() {
	case "$*" in
		--kernel-cc=*)
			CMD_KERNEL_CC=`parse_opt "$*"`
			print_info 2 "CMD_KERNEL_CC: ${CMD_KERNEL_CC}"
			;;
		--kernel-ld=*)
			CMD_KERNEL_LD=`parse_opt "$*"`
			print_info 2 "CMD_KERNEL_LD: ${CMD_KERNEL_LD}"
			;;
		--kernel-as=*)
			CMD_KERNEL_AS=`parse_opt "$*"`
			print_info 2 "CMD_KERNEL_AS: ${CMD_KERNEL_AS}"
			;;
		--kernel-make=*)
			CMD_KERNEL_MAKE=`parse_opt "$*"`
			print_info 2 "CMD_KERNEL_MAKE: ${CMD_KERNEL_MAKE}"
			;;
		--kernel-cross-compile=*)
			CMD_KERNEL_CROSS_COMPILE=`parse_opt "$*"`
			CMD_KERNEL_CROSS_COMPILE=$(echo ${CMD_KERNEL_CROSS_COMPILE}|sed -e 's/.*[^-]$/&-/g')
			print_info 2 "CMD_KERNEL_CROSS_COMPILE: ${CMD_KERNEL_CROSS_COMPILE}"
			;;
		--utils-cc=*)
			CMD_UTILS_CC=`parse_opt "$*"`
			print_info 2 "CMD_UTILS_CC: ${CMD_UTILS_CC}"
			;;
		--utils-ld=*)
			CMD_UTILS_LD=`parse_opt "$*"`
			print_info 2 "CMD_UTILS_LD: ${CMD_UTILS_LD}"
			;;
		--utils-as=*)
			CMD_UTILS_AS=`parse_opt "$*"`
			print_info 2 "CMD_UTILS_AS: ${CMD_UTILS_AS}"
			;;
		--utils-make=*)
			CMD_UTILS_MAKE=`parse_opt "$*"`
			print_info 2 "CMD_UTILS_MAKE: ${CMD_UTILS_MAKE}"
			;;
		--utils-cross-compile=*)
			CMD_UTILS_CROSS_COMPILE=`parse_opt "$*"`
			CMD_UTILS_CROSS_COMPILE=$(echo ${CMD_UTILS_CROSS_COMPILE}|sed -e 's/.*[^-]$/&-/g')
			print_info 2 "CMD_UTILS_CROSS_COMPILE: ${CMD_UTILS_CROSS_COMPILE}"
			;;
		--utils-arch=*)
			CMD_UTILS_ARCH=`parse_opt "$*"`
			print_info 2 "CMD_UTILS_ARCH: ${CMD_ARCHOVERRIDE}"
			;;
		--makeopts=*)
			CMD_MAKEOPTS=`parse_opt "$*"`
			print_info 2 "CMD_MAKEOPTS: ${CMD_MAKEOPTS}"
			;;
		--mountboot)
			CMD_MOUNTBOOT=1
			print_info 2 "CMD_MOUNTBOOT: ${CMD_MOUNTBOOT}"
			;;
		--no-mountboot)
			CMD_MOUNTBOOT=0
			print_info 2 "CMD_MOUNTBOOT: ${CMD_MOUNTBOOT}"
			;;
		--bootdir=*)
			CMD_BOOTDIR=`parse_opt "$*"`
			print_info 2 "CMD_BOOTDIR: ${CMD_BOOTDIR}"
			;;
		--do-keymap-auto)
			CMD_DOKEYMAPAUTO=1
			CMD_KEYMAP=1
			print_info 2 "CMD_DOKEYMAPAUTO: ${CMD_DOKEYMAPAUTO}"
			;;
		--no-keymap)
			CMD_KEYMAP=0
			print_info 2 "CMD_KEYMAP: ${CMD_KEYMAP}"
			;;
		--evms)
			CMD_EVMS=1
			print_info 2 "CMD_EVMS: ${CMD_EVMS}"
			;;
		--evms2)
			CMD_EVMS=1
			print_info 2 "CMD_EVMS: ${CMD_EVMS}"
			echo
			print_warning 1 "Please use --evms, as --evms2 is deprecated."
			;;
		--lvm)
			CMD_LVM=1
			print_info 2 "CMD_LVM: ${CMD_LVM}"
			;;
		--lvm2)
			CMD_LVM=1
			print_info 2 "CMD_LVM: ${CMD_LVM}"
			echo
			print_warning 1 "Please use --lvm, as --lvm2 is deprecated."
			;;
		--mdadm)
			CMD_MDADM=1
			print_info 2 "CMD_MDADM: $CMD_MDADM"
			;;
		--no-busybox)
			CMD_BUSYBOX=0
			print_info 2 "CMD_BUSYBOX: ${CMD_BUSYBOX}"
			;;
		--unionfs)
			CMD_UNIONFS=1
			print_info 2 "CMD_UNIONFS: ${CMD_UNIONFS}"
			;;
		--netboot)
			CMD_NETBOOT=1
			print_info 2 "CMD_NETBOOT: ${CMD_NETBOOT}"
			;;
		--real-root=*)
			CMD_REAL_ROOT=`parse_opt "$*"`
			print_info 2 "CMD_REAL_ROOT: ${CMD_REAL_ROOT}"
			;;
		--slowusb)
			CMD_SLOWUSB=1
			print_info 2 "CMD_SLOWUSB: ${CMD_SLOWUSB}"
			;;
		--dmraid)
			if [ ! -e /usr/include/libdevmapper.h ]
			then
				echo 'Error: --dmraid requires device-mapper to be installed'
				echo '		 on the host system; try "emerge device-mapper".'
				exit 1
			fi
			CMD_DMRAID=1
			print_info 2 "CMD_DMRAID: ${CMD_DMRAID}"
			;;
		--multipath)
			if [ ! -e /usr/include/libdevmapper.h ]
			then
				echo 'Error: --multipath requires device-mapper to be installed'
				echo '		 on the host;system; try "emerge device-mapper".'
				exit 1
			fi
			CMD_MULTIPATH=1
			print_info 2 "CMD_MULTIPATH: ${CMD_MULTIPATH}"
			;;
		--bootloader=*)
			CMD_BOOTLOADER=`parse_opt "$*"`
			print_info 2 "CMD_BOOTLOADER: ${CMD_BOOTLOADER}"
			;;
		--iscsi)
			CMD_ISCSI=1
			print_info 2 "CMD_ISCSI: ${CMD_ISCSI}"
			;;
		--loglevel=*)
			CMD_LOGLEVEL=`parse_opt "$*"`
			LOGLEVEL="${CMD_LOGLEVEL}"
			print_info 2 "CMD_LOGLEVEL: ${CMD_LOGLEVEL}"
			;;
		--menuconfig)
			TERM_LINES=`stty -a | head -n 1 | cut -d\  -f5 | cut -d\; -f1`
			TERM_COLUMNS=`stty -a | head -n 1 | cut -d\  -f7 | cut -d\; -f1`
			if [[ TERM_LINES -lt 19 || TERM_COLUMNS -lt 80 ]]
			then
				echo "Error: You need a terminal with at least 80 columns"
				echo "		 and 19 lines for --menuconfig; try --nomenuconfig..."
				exit 1
			fi
			CMD_MENUCONFIG=1
			print_info 2 "CMD_MENUCONFIG: ${CMD_MENUCONFIG}"
			;;
		--no-menuconfig)
			CMD_MENUCONFIG=0
			print_info 2 "CMD_MENUCONFIG: ${CMD_MENUCONFIG}"
			;;
		--gconfig)
			CMD_GCONFIG=1
			print_info 2 "CMD_GCONFIG: ${CMD_GCONFIG}"
			;;
		--xconfig)
			CMD_XCONFIG=1
			print_info 2 "CMD_XCONFIG: ${CMD_XCONFIG}"
			;;
		--save-config)
			CMD_SAVE_CONFIG=1
			print_info 2 "CMD_SAVE_CONFIG: ${CMD_SAVE_CONFIG}"
			;;
		--no-save-config)
			CMD_SAVE_CONFIG=0
			print_info 2 "CMD_SAVE_CONFIG: ${CMD_SAVE_CONFIG}"
			;;
		--mrproper)
			CMD_MRPROPER=1
			print_info 2 "CMD_MRPROPER: ${CMD_MRPROPER}"
			;;
		--no-mrproper)
			CMD_MRPROPER=0
			print_info 2 "CMD_MRPROPER: ${CMD_MRPROPER}"
			;;
		--clean)
			CMD_CLEAN=1
			print_info 2 "CMD_CLEAN: ${CMD_CLEAN}"
			;;
		--no-clean)
			CMD_CLEAN=0
			print_info 2 "CMD_CLEAN: ${CMD_CLEAN}"
			;;
		--oldconfig)
			CMD_CLEAN=0
			CMD_OLDCONFIG=1
			print_info 2 "CMD_CLEAN: ${CMD_CLEAN}"
			print_info 2 "CMD_OLDCONFIG: ${CMD_OLDCONFIG}"
			;;
		--gensplash=*)
			CMD_SPLASH=1
			SPLASH_THEME=`parse_opt "$*"`
			print_info 2 "CMD_SPLASH: ${CMD_SPLASH}"
			print_info 2 "SPLASH_THEME: ${SPLASH_THEME}"
			echo
			print_warning 1 "Please use --splash, as --gensplash is deprecated."
			;;
		--gensplash)
			CMD_SPLASH=1
			SPLASH_THEME='default'
			print_info 2 "CMD_SPLASH: ${CMD_SPLASH}"
			echo
			print_warning 1 "Please use --splash, as --gensplash is deprecated."
			;;
		--splash=*)
			CMD_SPLASH=1
			SPLASH_THEME=`parse_opt "$*"`
			print_info 2 "CMD_SPLASH: ${CMD_SPLASH}"
			print_info 2 "SPLASH_THEME: ${SPLASH_THEME}"
			;;
		--splash)
			CMD_SPLASH=1
			SPLASH_THEME='default'
			print_info 2 "CMD_SPLASH: ${CMD_SPLASH}"
			;;
		--no-splash)
			CMD_SPLASH=0
			print_info 2 "CMD_SPLASH: ${CMD_SPLASH}"
			;;
		--gensplash-res=*)
			SPLASH_RES=`parse_opt "$*"`
			print_info 2 "SPLASH_RES: ${SPLASH_RES}"
			echo
			print_warning 1 "Please use --splash-res, as --gensplash-res is deprecated."
			;;
		--splash-res=*)
			SPLASH_RES=`parse_opt "$*"`
			print_info 2 "SPLASH_RES: ${SPLASH_RES}"
			;;
		--install)
			CMD_NOINSTALL=0
			print_info 2 "CMD_NOINSTALL: ${CMD_NOINSTALL}"
			;;
		--no-install)
			CMD_NOINSTALL=1
			print_info 2 "CMD_NOINSTALL: ${CMD_NOINSTALL}"
			;;
		--no-ramdisk-modules)
			CMD_NORAMDISKMODULES=1
			print_info 2 "CMD_NORAMDISKMODULES: ${CMD_NORAMDISKMODULES}"
			;;
		--all-ramdisk-modules)
			CMD_ALLRAMDISKMODULES=1
			print_info 2 "CMD_ALLRAMDISKMODULES: ${CMD_ALLRAMDISKMODULES}"
			;;
		--callback=*)
			CMD_CALLBACK=`parse_opt "$*"`
			print_info 2 "CMD_CALLBACK: ${CMD_CALLBACK}/$*"
			;;
		--static)
			CMD_STATIC=1
			print_info 2 "CMD_STATIC: ${CMD_STATIC}"
			;;
		--tempdir=*)
			TMPDIR=`parse_opt "$*"`
			TEMP=${TMPDIR}/$RANDOM.$RANDOM.$RANDOM.$$
			print_info 2 "TMPDIR: ${TMPDIR}"
			print_info 2 "TEMP: ${TEMP}"
			;; 
		--postclear)
			CMD_POSTCLEAR=1
			print_info 2 "CMD_POSTCLEAR: ${CMD_POSTCLEAR}"
			;; 
		--arch-override=*)
			CMD_ARCHOVERRIDE=`parse_opt "$*"`
			print_info 2 "CMD_ARCHOVERRIDE: ${CMD_ARCHOVERRIDE}"
			;;
		--color)
			USECOLOR=1
			print_info 2 "USECOLOR: ${USECOLOR}"
			setColorVars
			;;
		--no-color)
			USECOLOR=0
			print_info 2 "USECOLOR: ${USECOLOR}"
			setColorVars
			;;
		--logfile=*)
			CMD_LOGFILE=`parse_opt "$*"`
			LOGFILE=`parse_opt "$*"`
			print_info 2 "CMD_LOGFILE: ${CMD_LOGFILE}"
			print_info 2 "LOGFILE: ${CMD_LOGFILE}"
			;;
		--kerneldir=*)
			CMD_KERNEL_DIR=`parse_opt "$*"`
			print_info 2 "CMD_KERNEL_DIR: ${CMD_KERNEL_DIR}"
			;;
		--kernel-config=*)
			CMD_KERNEL_CONFIG=`parse_opt "$*"`
			print_info 2 "CMD_KERNEL_CONFIG: ${CMD_KERNEL_CONFIG}"
			;;
		--module-prefix=*)
			CMD_INSTALL_MOD_PATH=`parse_opt "$*"`
			print_info 2 "CMD_INSTALL_MOD_PATH: ${CMD_INSTALL_MOD_PATH}"
			;;
		--cachedir=*)
			CACHE_DIR=`parse_opt "$*"`
			print_info 2 "CACHE_DIR: ${CACHE_DIR}"
			;;
		--minkernpackage=*)
			CMD_MINKERNPACKAGE=`parse_opt "$*"`
			print_info 2 "MINKERNPACKAGE: ${CMD_MINKERNPACKAGE}"
			;;
		--modulespackage=*)
			CMD_MODULESPACKAGE=`parse_opt "$*"`
			print_info 2 "MODULESPACKAGE: ${CMD_MODULESPACKAGE}"
			;;
		--kerncache=*)
			CMD_KERNCACHE=`parse_opt "$*"`
			print_info 2 "KERNCACHE: ${CMD_KERNCACHE}"
			;;
		--kernname=*)
			CMD_KERNNAME=`parse_opt "$*"`
			print_info 2 "KERNNAME: ${CMD_KERNNAME}"
			;;
		--symlink)
			CMD_SYMLINK=1
			print_info 2 "CMD_SYMLINK: ${CMD_SYMLINK}"
			;;
		--no-symlink)
			CMD_SYMLINK=0
			print_info 2 "CMD_SYMLINK: ${CMD_SYMLINK}"
			;;
		--no-kernel-sources)
			CMD_NO_KERNEL_SOURCES=1
			print_info 2 "CMD_NO_KERNEL_SOURCES: ${CMD_NO_KERNEL_SOURCES}"
			;;
		--initramfs-overlay=*)
			CMD_INITRAMFS_OVERLAY=`parse_opt "$*"`
			print_info 2 "CMD_INITRAMFS_OVERLAY: ${CMD_INITRAMFS_OVERLAY}"
			;;
		--linuxrc=*)
			CMD_LINUXRC=`parse_opt "$*"`
			print_info 2 "CMD_LINUXRC: ${CMD_LINUXRC}"
			;;
		--busybox-config=*)
			CMD_BUSYBOX_CONFIG=`parse_opt "$*"`
			print_info 2 "CMD_BUSYBOX_CONFIG: ${CMD_BUSYBOX_CONFIG}"
			;;
		--genzimage)
			KERNEL_MAKE_DIRECTIVE_2='zImage.initrd'
			KERNEL_BINARY_2='arch/powerpc/boot/zImage.initrd'
			CMD_GENZIMAGE="yes"
#			ENABLE_PEGASOS_HACKS="yes"
#			print_info 2 "ENABLE_PEGASOS_HACKS: ${ENABLE_PEGASOS_HACKS}"
			;;
		--disklabel)
			CMD_DISKLABEL=1
			print_info 2 "CMD_DISKLABEL: ${CMD_DISKLABEL}"
			;;
		--luks)
			CMD_LUKS=1
			print_info 2 "CMD_LUKS: ${CMD_LUKS}"
			;;
		--firmware)
			CMD_FIRMWARE=1
			print_info 2 "CMD_FIRMWARE: ${CMD_FIRMWARE}"
			;;
		--firmware-dir=*)
			CMD_FIRMWARE_DIR=`parse_opt "$*"`
			CMD_FIRMWARE=1
			print_info 2 "CMD_FIRMWARE_DIR: ${CMD_FIRMWARE_DIR}"
			;;
		--firmware-files=*)
			CMD_FIRMWARE_FILES=`parse_opt "$*"`
			CMD_FIRMWARE=1
			print_info 2 "CMD_FIRMWARE_FILES: ${CMD_FIRMWARE_FILES}"
			;;
		--integrated-initramfs)
			CMD_INTEGRATED_INITRAMFS=1
			print_info 2 "CMD_INTEGRATED_INITRAMFS=${CMD_INTEGRATED_INITRAMFS}"
			;;
		--config=*)
			print_info 2 "CMD_GK_CONFIG: `parse_opt "$*"`"
			;;
		all)
			BUILD_KERNEL=1
			BUILD_MODULES=1
			BUILD_RAMDISK=1
			;;
		ramdisk|initramfs)
			BUILD_RAMDISK=1
			;;
		kernel)
			BUILD_KERNEL=1
			BUILD_MODULES=1
			BUILD_RAMDISK=0
			;;
		bzImage)
			BUILD_KERNEL=1
			BUILD_MODULES=0
			BUILD_RAMDISK=1
			CMD_NORAMDISKMODULES=1
			print_info 2 "CMD_NORAMDISKMODULES: ${CMD_NORAMDISKMODULES}"
			;;
		--help)
			longusage
			exit 1
			;;
		--version)
			echo "${GK_V}"
			exit 0
			;;
		*)
			echo "Error: Unknown option '$*'!"
			exit 1
			;;
	esac
}
