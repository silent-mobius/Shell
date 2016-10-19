#!/usr/bin/env bash
#set -x

########################################################################
#TODO:need to add verification on all function. 
#
#
#
########################################################################


###Vars ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
logFolder="/tmp"
log="install_log.txt"
logFile="$logFile/$log"
PASSWD="1"
USER="mobius"
KODENAME="jessie"
REPONAME="debian"
declare -a packages=( 'lightdm' 'mate-desktop-environment-extras' 'firmware-realtek' 'firmware-linux' 'firmware-linux-free'
'firmware-linux-nonfree' 'vlc' 'gparted' 'abiword' 'transmission' 'guake' 'mixxx' 'culmus' 'xfonts-efont-unicode'
'xfonts-efont-unicode-ib' 'xfonts-intl-european' 'guake' 'zenmap' 'nmapsi4'  'ettercap-graphical'  'bluedevil' 'bluemon'
'bluez-firmware' 'bluez-tools' 'bluez-hcidump'  'bluez-obexd' 'blueproximity' 'glances' 'atop' 'unrar' 'p7zip' 'vim-gtk' 
'sqlitebrowser' 'ttf-mscorefonts-installer' 'sqlite' 'sqlite3' 'mysql-client' 'mysql-server'
'postgresql' 'apache2' 'nginx-full' 'nfs-common' 'samba-common' 'redis-server' 'sysv-rc-conf' 'wget' 'curl' 'nmap'
'zenmap' 'aircrack-ng' 'dsniff' 'ndiff' 'nbtscan' 'wireshark' 'tcpreplay' 'graphviz' 'python-gnuplot' 'python-pyx' 'ebtables'
'python-visual' 'sox' 'xpdf' 'gv' 'hexer' 'librsvg2-bin' 'python-pcapy' 'tshark' 'tcpdump' 'netcat' 'macchanger' 'python-scapy'
'python-pip' 'python-networkx' 'python-netaddr' 'python-netifaces' 'python-netfilter' 'python-gnuplot' 'python-mako'
'python-radix' 'ipython' 'python-pycurl' 'python-lxml' 'python-libpcap' 'python-nmap' 'python-flask' 'python-scrapy'
'libpoe-component-pcap-perl' 'libnet-pcap-perl' 'perl-modules' 'geany' 'icedove' 'thunderbird' 'build-essential' 'debhelper'
'cmake' 'bison' 'flex' 'libgtk2.0-dev' 'libltdl3-dev' 'libncurses-dev' 'libusb-1.0-0-dev' 'git' 'git-core' 'libncurses5-dev'
'libnet1-dev' 'libpcre3-dev' 'libssl-dev' 'libcurl4-openssl-dev' 'ghostscript' 'autoconf' 'python-software-properties'
'debian-goodies' 'freeglut3-dev' 'libxmu-dev' 'libpcap-dev' 'libglib2.0' 'libxml2-dev' 'libpcap-dev' 'libtool'
'rrdtool' 'autoconf' 'automake' 'autogen' 'redis-server' 'libsqlite3-dev' 'libhiredis-dev' 'libgeoip-dev'
'debootstrap' 'qemu-user-static' 'device-tree-compiler' 'lzma' 'lzop' 'pixz' 'dkms' 'gnupg' 'flex' 'bison' 'gperf'
'libesd0-dev' 'zip' 'curl' 'libncurses5-dev' 'zlib1g-dev' 'gcc-multilib' 'g++-multilib' 'libusb-1.0-0'
'libusb-1.0-0-dev' 'fakeroot' 'kernel-package' 'zlib1g-dev' 'devscripts' 'pbuilder' 'dh-make' 'mingw32'
'mingw32-binutils' 'guake' 'nasm' 'genisoimage' 'bochs' 'bochs-sdl' 'unrar' 'p7zip' 'gns3' 'vim' 'vim-gtk' 'guake' 'plank'
'ninja-ide' 'codeblocks' 'htop' 'hexedit' )

###Funcs /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
help(){
	echo -e '\n usage : OS_setup.sh -I apt-get -U username -P password \n'

	}

	insert_repo(){ # case statement to choose between DEbian and KAli
			###TODO - add ubuntu --> done
					##Future options for RPM base done
		op=$1
		case $op in

			$REPONAME)	echo "
##MAIN
deb http://http.$REPONAME.net/$REPONAME $KODENAME main
deb-src http://http.$REPONAME.net/$REPONAME $KODENAME main

deb http://http.$REPONAME.net/$REPONAME $KODENAME-updates main
deb-src http://http.$REPONAME.net/$REPONAME $KODENAME-updates main

deb http://security.$REPONAME.org/ $KODENAME/updates main
deb-src http://security.$REPONAME.org/ $KODENAME/updates main

deb ftp://ftp.$REPONAME.org/$REPONAME stable main contrib non-free
###BackPort
deb http://http.$REPONAME.net/$REPONAME $KODENAME-backports main
deb http://ftp.$REPONAME.org/$REPONAME/ $KODENAME-backports non-free contrib
	" > /etc/apt/sources.list
	echo "deb http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/Debian_7.0/ /" >> /etc/apt/sources.list
	echo "deb http://download.virtualbox.org/virtualbox/debian jessie contrib" >> /etc/apt/sources.list
	;;
			*) echo "Error getting Repo";exit 1 ;;

	esac
		}

netCheck(){
	net_stat=`ping -c 1 vk.com > /dev/null 2> /dev/null ;echo $?`
			if [ $net_stat == "1" ] || [ $net_stat == "2" ];then
				echo "NO NETWORK - "
				exit
			elif [ $net_stat == "0" ];then
					echo "Network is UP";sleep 2;echo "starting app install";
					pacInstall
					echo "finished installing packages"
			fi
	}

pacInstall(){
	apt-get update;
	for i in "${packages[@]}";do
		pacCheck=`dpkg -l $i > /dev/null;echo $?`
			if [ "$pacCheck" == "0" ];then
				True
			else
				apt-get install -y $i
			fi
	done
	}


	set_working_env(){ #user env setup
	  useradd -m -p `mkpasswd "$PASSWD"` -s /bin/bash -G adm,sudo,www-data,root $USER
	#       echo $PASSWD|passwd $USER --stdin
	  sed s/PS1/#PS1/ /etc/bash.bashrc
	  ##creating aliases
	  echo "if [ $UID == '0' ];then
	              PS1='\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[0;31m\]\# \[\e[m\]\[\e[0;32m\]'
	         else
	              PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
	          fi" >> /etc/bash.bashrc
	  echo "alias l=ls; alias ll='ls -l'; alias la='ls -la';alias lh='ls -lh'
	  alias more=less; alias vi=vim; alias cl=clear; alias mv='mv -v'; alias cp='cp -v';
	  alias log='cd /var/log'; alias drop_caches='echo 3 > /proc/sys/vm/drop_caches';
	  alias ip_forward='echo 1 > /proc/sys/net/ipv4/ip_forward';
	  alias self_destruct='dd if=/dev/zero of=/dev/sda'
	  #export PATH=$PATH:/opt/VirtualGL/bin:/usr/local/cuda-6.5/bin;
	  #export CROSS_COMPILE=/opt/arm-tools/kernel/toolchains/gcc-arm-eabi-linaro-4.6.2/bin/arm-eabi-" >> /etc/bash.bashrc;
	  source /etc/bash.bashrc
	: '  #removing kali pics
		if [ `uname -a|grep kali > /dev/null;echo $?` == "0" ];then
			updatedb;locate kali |grep png > pics.txt
				while read line;do rm -rf $line;done  < pics.txt
