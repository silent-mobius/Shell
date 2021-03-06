#!/usr/bin/env bash
############################################################33
#created by : br0k3ngl255
#date :
#Purpose : create env for oracle install
############################################################33

###Vars  ++++++++++++++++++++++++++++++++++++++++++++++++++++
USER="oracle"
PASSWD="1"
###Funcs ::::::::::::::::::::::::::::::::::::::::::::::::::::

f_pack_install(){
apt-get install  build-essential rpm libaio1 libaio-dev libmotif4 libtool expat \n
 alien ksh pdksh unixodbc unixodbc-dev sysstat elfutils libelf-dev lesstif \n
 	libstd++5 binutils python-devel -y
}

f_links(){
if [ -e /usr/lib64 ];then
	true
else
	mkdir /usr/lib64
fi
	for i in awk basename rpm;
		do
			ln -s  /usr/bin/$i /bin/$i
		done
	for j in libc_nonshared.a kibpthread_nonshared.a libstdc++.so.6;
		do
			ln -s /usr/lib/x86_64-linux-gnu/$j /usr/lib64/$j
		done
ln -s /etc /etc/rc.d
ln -s /lib/x86_64-linux-gnu/libgcc_s.so.1 /lib64/
ln -s /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /usr/lib64/

}

f_ora_user_setup(){
 if [ "$EUID" != "0" ];then
    	echo "need root access"; exit
     else
             declare -a Groups=('dba', 'nobody', 'oinstall')
             for i in ${Groups[@]};
             do
                group_exist=`cat /etc/group|grep fibo &> /dev/null ;echo $?`
                   if [ "$group_exist" == "0" ];then
                      groupadd $i;
                    else true
                   fi
              done
              #    oinstall; groupadd dba; groupadd nobody # fixed addgroup to groupadd
              #   usermod -g nobody nobody  #need to test the group creattion
                user_exits=`cat /etc/passwd|grep $USER &> /dev/null;echo $?`
                if [ "$user_exits" == "0" ];then
                    true;
                else
                    useradd -g dba -G oinstall -p $PASSWD -d /home/$USER -s /bin/bash $USER;
                fi

      # useradd -g oinstall -G dba -p password -d /home/oracle -s /bin/bash oracle # also test if user and its groups are created and then run the creation
               if [  -d /home/oracle ];then
                 mkdir /home/oracle
                 chown -R oracle:dba /home/oracle
               fi
      					if [ -e /home/oracle/.bashrc ];then
      						echo "
      								export ORACLE_HOSTNAME=localhost
      								export ORACLE_OWNER=oracle
      								export ORACLE_BASE=/u01/app/oracle
      								export ORACLE_HOME=/u01/app/oracle/product/11.2.0/dbhome_1
      								export ORACLE_UNQNAME=orcl
      								export ORACLE_SID=orcl
      								export PATH=$PATH:$ORACLE_HOME/bin
      								export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu:/bin/lib:/lib/x86_64-linux-gnu/:/usr/lib64
      						" >> /home/oracle/.bash_profile; source /home/oracle/.bash_profile
      					else
      							touch /home/oracle/.bash_profile
      							echo "
      									export ORACLE_HOSTNAME=localhost
      									export ORACLE_OWNER=oracle
      									export ORACLE_BASE=/u01/app/oracle
      									export ORACLE_HOME=/u01/app/oracle/product/11.2.0/dbhome_1
      									export ORACLE_UNQNAME=orcl
      									export ORACLE_SID=orcl
      									export PATH=$PATH:$ORACLE_HOME/bin
      									export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu:/bin/lib:/lib/x86_64-linux-gnu/:/usr/lib64
      							" >> /home/oracle/.bash_profile; source  /home/oracle/.bash_profile
      					fi
                if [ -d /u01 ];then # may be i just should test only one dir and ac accordingly
                        if [ -d /u01/app ];then # need to test according to code efficiency
                                if [ -d /u01/app/oracle ];then
                                  true
                                fi
                          true
                        fi
                true
                else
                  mkdir -p /u01/app/oracle
                  chown -R oracle:dba /u01
                fi
    		  fi
    #fi
}

f_ora_kernel_setup(){
echo "

#Oracle 11gR2 entries :
fs.aio-max-nr=1048576
fs.file-max=6815744
kernel.shmall=2097152
kernel.shmmni=4096
kernel.sem= 250 32000 100 128
net.ipv4.ip_local_port_range=9000 65500
net.core.rmem_default=262144
net.core.rmem_max=4194304
net.core.wmem_default=262144
net.core.wmem_max=1048586
kernel.shmmax=1073741824

" >> /etc/sysctl.d/oracle.conf; sysctl -p /etc/sysctl.d/oracle.conf

echo "

#Oracle 11gR2 sec conf shell limits:
oracle soft nproc 2048
oracle hard nproc 16384
oracle soft nofile 1024
oracle hard nofile 65536


" >> /etc/security/limits.conf
}

###
#MAIN - _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _- _-
###

if [ "$EUID" != "0" ];then
      	echo "Some of the functions of the script won't work plese get Root access"
      	sleep 5

      	read -p "Would you still like to continue ?[Y/n]" ans
      		case $ans in
      		y|Y) f_pack_install;f_links;f_ora_kernel_setup;f_ora_user_setup ;;
      		n|N)  f_links;;
      	esac
      	echo -e "please download Oracle install files from : \n
      			http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html \n
      			unzip it and run the install it by running :\n
      				cd /home/oracle \n
      				unzip linux.x64_11gR2_database_* \n
      				chmod 777 -R database			 \n
      				./runinstaller -ignoreSysPrereqs  \n
      "
else

      	 f_pack_install;f_links;f_ora_kernel_setup;f_ora_user_setup
      	echo -e "please download Oracle install files from : \n
      			http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html \n
      			unzip it and run the install it by running :\n
      				cd /home/oracle \n
      				unzip linux.x64_11gR2_database_* \n
      				chmod 777 -R database			 \n
      				./runinstaller -ignoreSysPrereqs  \n
      "
fi
