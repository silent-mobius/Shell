#!/usr/bin/env bash


########################################################################
#
#
#
#
########################################################################


###Vars ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::




declare -a packages=( 'lightdm','mate-desktop-environment-extras', 'firmware-realtek', 'firmware-linux', 'firmware-linux-free',
'firmware-linux-nonfree', 'vlc', 'gparted', 'abiword', 'transmission', 'guake', 'mixxx', 'culmus', 'xfonts-efont-unicode',
'xfonts-efont-unicode-ib', 'xfonts-intl-european', 'ttf-mscorefonts-installer', 'sqlite', 'sqlite3', 'mysql-client', 'mysql-server',
'postgresql', 'apache2', 'nginx-full', 'nfs-common', 'samba-common', 'redis-server', 'sysv-rc-conf', 'wget', 'curl', 'nmap',
'zenmap', 'aircrack-ng', 'dsniff', 'ndiff', 'nbtscan', 'wireshark', 'tshark', 'tcpdump', 'netcat', 'macchanger', 'python-scapy',
'python-pip', 'python-networkx', 'python-netaddr', 'python-netifaces', 'python-netfilter', 'python-gnuplot', 'python-mako',
'python-radix', 'ipython', 'python-pycurl', 'python-lxml', 'python-libpcap', 'python-nmap', 'python-flask', 'python-scrapy',
'libpoe-component-pcap-perl', 'libnet-pcap-perl', 'perl-modules', 'geany', 'build-essential', 'debhelper', 'cmake', 'bison',
'flex', 'libgtk2.0-dev', 'libltdl3-dev', 'libncurses-dev', 'libusb-1.0-0-dev', 'git', 'git-core', 'libncurses5-dev',
'libnet1-dev', 'libpcre3-dev', 'libssl-dev', 'libcurl4-openssl-dev', 'ghostscript', 'autoconf', 'python-software-properties',
'debian-goodies', 'freeglut3-dev', 'libxmu-dev', 'libpcap-dev', 'libglib2.0', 'libxml2-dev', 'libpcap-dev', 'libtool',
'rrdtool', 'autoconf', 'automake', 'autogen', 'redis-server', 'libsqlite3-dev', 'libhiredis-dev', 'libgeoip-dev',
'debootstrap', 'qemu-user-static', 'device-tree-compiler', 'lzma', 'lzop', 'pixz', 'dkms', 'gnupg', 'flex', 'bison', 'gperf',
'libesd0-dev', 'zip', 'curl', 'libncurses5-dev', 'zlib1g-dev', 'gcc-multilib', 'g++-multilib', 'libusb-1.0-0',
'libusb-1.0-0-dev', 'fakeroot', 'kernel-package', 'zlib1g-dev', 'devscripts', 'pbuilder', 'dh-make', 'mingw32',
'mingw32-binutils', 'guake', 'nasm', 'genisoimage', 'bochs', 'bochs-sdl', 'unrar', 'gns3')

###Funcs /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
help(){
	echo -e '\n usage : OS_setup.sh -I apt-get -U username -P password \n'
	
	}
netCheck(){
	net_stat=`ping -c 1 vk.com > /dev/null 2> /dev/null ;echo $?`
	if [ $net_stat == "1" ] || [ $net_stat == "2" ];then
		echo "NO NETWORK - "
		exit
	fi
	}

pacInstall(){
	for i in "${packages[@]}";do
		pacCheck=`dpkg -l $i > /dev/null;echo $?`	
		if [ "$pacCheck" == "0" ];then
			True
		else
			apt-get install $i
		fi
	done
	}

####
#Main - _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _
####

if [ "$EUID" == "0" ];then

fi
