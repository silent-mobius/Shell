#!/usr/bin/env bash
#set -x

########################################################################
#created by br0k3ngl255
#purpose: not to do any after install manually
#
########################################################################


###Vars ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
logFolder="/tmp"
log="install_log.txt"
logFile="$logFile/$log"
REPONAME="`lsb_release -si|awk {'print tolower ($0)'}`"
KODENAME="`lsb_release -sc`"
PASSWD="1"
USER="mobius"
export DEBIAN_FRONTEND=noninteractive
declare -a packages=(  'lightdm' 'mate-desktop-environment-extras' 'firmware-realtek' 'firmware-linux' 'firmware-linux-free'
'firmware-linux-nonfree' 'vlc' 'gparted' 'abiword' 'transmission' 'guake' 'mixxx' 'culmus' 'xfonts-efont-unicode' 
'xfonts-efont-unicode-ib' 'xfonts-intl-european' 'ttf-mscorefonts-installer' 'sqlite' 'sqlite3' 'mysql-client' 'mysql-server'
'postgresql' 'apache2' 'nginx-full' 'nfs-common' 'samba-common' 'redis-server' 'sysv-rc-conf' 'wget' 'curl' 'nmap' 'zenmap'
'aircrack-ng' 'dsniff' 'ndiff' 'nbtscan' 'wireshark' 'tshark' 'tcpdump' 'netcat' 'macchanger' 'python-scapy' 'python-pip' 
'python-networkx' 'python-netaddr' 'python-netifaces' 'python-netfilter' 'python-gnuplot' 'python-mako' 'python-radix'
'ipython' 'python-pycurl' 'python-lxml' 'python-libpcap' 'python-nmap' 'python-flask' 'python-scrapy' 
'libpoe-component-pcap-perl' 'libnet-pcap-perl' 'perl-modules' 'geany' 'build-essential' 'debhelper' 'cmake' 'bison' 'flex'
'libgtk2.0-dev' 'libltdl3-dev' 'libncurses-dev' 'libusb-1.0-0-dev' 'git' 'git-core' 'libncurses5-dev' 'gnome-common' 'intltool'
'pkg-config' 'valac' 'libbamf3-dev' 'libdbusmenu-gtk3-dev' 'libgdk-pixbuf2.0-dev' 'libgee-dev' 'libglib2.0-dev' 'libgtk-3-dev'
'libwnck-3-dev' 'libx11-dev' 'libgee-0.8-dev' 'libnet1-dev' 'libpcre3-dev' 'libssl-dev' 'libcurl4-openssl-dev' 'ghostscript'
'autoconf' 'python-software-properties' 'debian-goodies' 'freeglut3-dev' 'libxmu-dev' 'libpcap-dev' 'libglib2.0' 'libxml2-dev'
'libpcap-dev' 'libtool' 'rrdtool' 'autoconf' 'automake' 'autogen' 'redis-server' 'libsqlite3-dev' 'libhiredis-dev' 
'firmware-iwlwifi' 'libgeoip-dev' 'debootstrap' 'qemu-user-static' 'device-tree-compiler' 'lzma' 'lzop' 'pixz' 'dkms' 'gnupg'
'flex' 'bison' 'gperf' 'libesd0-dev' 'zip' 'curl' 'libncurses5-dev' 'zlib1g-dev' 'gcc-multilib' 'g++-multilib' 'libusb-1.0-0'
'icedove' 'thunderbird' 'libusb-1.0-0-dev' 'fakeroot' 'kernel-package' 'zlib1g-dev' 'devscripts' 'pbuilder' 'dh-make' 'mingw32' 
'mingw32-binutils' 'guake' 'nasm' 'genisoimage' 'bochs' 'bochs-sdl' 'unrar' 'p7zip' 'gns3' 'vim' 'vim-gtk' 'guake' 'plank' 
'ninja-ide' 'codeblocks' 'htop' 'hexedit' 'vim' 'vim-gtk' 'icedove' 'vagrant' 'virtualbox-4.3' 'debian-keyring' 'g++-multilib'
'g++-4.9-multilib' 'libstdc++6-4.9-dbg' 'python-dev' 'python-cryptography-vectors' 'geany-plugin-scope' 'sunxi-tools'
 'monodevelop' 'bash-completion')

###Funcs /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
help(){
	echo -e "\n usage : OS_setup.sh -I apt-get -U username -P password \n"

	}


insertRepo(){ # case statement to choose between DEbian and KAli
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
	echo "deb http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/Debian_7.0/ /"g >> /etc/apt/sources.list
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
					insertRepo $REPONAME
					apt-get update
					echo "finished updating repo cache"
			fi
	}
	
repoCerts(){ #TODO - save all in /tmp
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- |  apt-key add - ;
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- |  apt-key add - ;
wget -q  http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/Debian_7.0/Release.key -O- |apt-key add - ;
}

pacInstall(){
	for i in "${packages[@]}";do
		pacCheck=$(dpkg -l $i &> $logFile;echo $?)
			if [ "$pacCheck" == "0" ];then
				true
			else
				apt-get install -y $i &> $logFile
			fi
	done
	}

linkInstall(){ #TODO -> save all in /opt and install them from there
declare -a LINKS=(
					"http://download.teamviewer.com/download/teamviewer_amd64.deb"
					"https://geany-vibrant-ink-theme.googlecode.com/files/vibrant_ink_geany_filedefs_20111207.zip"
					"https://download.jetbrains.com/python/pycharm-professional-2016.2.3.tar.gz"
					"https://atom.io/download/deb"
					"http://kdl.cc.ksosoft.com/wps-community/download/a21/wps-office_10.1.0.5672~a21_amd64.deb" 
				)
for i in ${LINKS[@]}
	do
       cmd=$(which $i &> $logFile;echo $?)
            if [ "$cmd" != "0" ];then
        		wget $i &> $logFile $
            else	
                true
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
	  echo -e "\n if ! shopt -oq posix; then  
						if [ -f /usr/share/bash-completion/bash_completion ]; then
							. /usr/share/bash-completion/bash_completion
						elif [ -f /etc/bash_completion ]; then
							. /etc/bash_completion
						fi  
				  fi" >> /etc/bash.bashrc;    #although inserting into the file but, it could be nice to implement sed or awk to filter already existing configuration
	  echo "  alias l=ls; alias ll='ls -l'; alias la='ls -la';alias lh='ls -lh'
			  alias more=less; alias vi=vim; alias cl=clear; alias mv='mv -v'; alias cp='cp -v';
			  alias log='cd /var/log'; alias drop_caches='echo 3 > /proc/sys/vm/drop_caches';
			  alias ip_forward='echo 1 > /proc/sys/net/ipv4/ip_forward';
			  alias self_destruct='dd if=/dev/zero of=/dev/sda'
			  #export PATH=$PATH:/opt/VirtualGL/bin:/usr/local/cuda-6.5/bin;
			  #export CROSS_COMPILE=/opt/arm-tools/kernel/toolchains/gcc-arm-eabi-linaro-4.6.2/bin/arm-eabi-" >> /etc/bash.bashrc;
		source /etc/bash.bashrc
		file_check=$(ls /usr/share/backgrounds/cosmos/comet.jpg >> /dev/null;echo $?)
				if [ "$file_check" == "0" ];then
					#gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/cosmos/comet.jpg'
					sed -i 's/background=\/usr\/share\/images\/desktop-base\/login-background\.svg/background=\/usr\/share\/backgrounds\/cosmos\/comet\.jpg/' /etc/lightdm/lightdm-gtk-greeter.conf
				else
					true
				fi
		bg_check=$(cat  /etc/default/grub |grep -i grub_background &> /dev/null;echo $?)
				if [ "$bg_check" == "0" ];then
					true
				else
					echo 'GRUB_BACKGROUND="/usr/share/backgrounds/cosmos/comet.jpg"' >> /etc/default/grub;
						grub-mkconfig -o /boot/grub/grub.cfg
				fi
			#runnfing functions	
			repoCerts;linkInstall;getClones;pacInstall
	    }



getClones(){ # TODO -> clone in /opt and soft link them to  Desktop
		git clone https://github.com/silent-mobius/Shell.git
		git clone https://github.com/silent-mobius/Python.git
} 

####
#Main - _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _
####
while getopts ":i:u:p:" opt;do
	case $opt in

		i)	INSTALL_MNGR=$OPTARG;;
		u)	USER=$OPTARG;;
		p)	PASSWD=$OPTARG;;
		*)  echo "error";;

	esac
done

if [ "$EUID" != "0" ];then
		echo "Please get Root priviledges"
		help;sleep 2;exit
else
		netCheck
		set_working_env;
fi 
