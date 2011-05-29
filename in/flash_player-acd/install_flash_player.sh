#!/bin/bash - 
#===============================================================================
#
#          FILE:  script.sh
# 
#         USAGE:  ./script.sh Insert your dick. keep it in.
# 
#   DESCRIPTION:  Install Flash player 10.3 for 32 and 64 bits
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  Architecture 32 or 64 bits
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: José Juan Ibáñez Cemborain, 
#       COMPANY: 
#       CREATED: 06/01/10 14:21:24 CET
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#!/bin/bash
USERID=`id -u`
ARCH=`uname -m`
DIR_ID_SUFIX=`date +%d_%m_%Y_%k_%M_%N`
NO_VERSION=0
 
if [ $USERID -ne 0 ]; then
	echo "Flash Player required legged in as root"
	exit
fi

mkdir "/tmp/Flashplayer.$DIR_ID_SUFIX"

if [ "$ARCH" == i686 ]; then
	echo "Downloading Flash Player to /tmp for 32 bits"
	wget -v http://fpdownload.macromedia.com/get/flashplayer/current/install_flash_player_10_linux.tar.gz --directory-prefix="/tmp/Flashplayer.$DIR_ID_SUFIX"

	echo "unpacking Flash Player to /tmp"
	tar -xvf "/tmp/Flashplayer.$DIR_ID_SUFIX/install_flash_player_10_linux.tar.gz" -C "/tmp/Flashplayer.$DIR_ID_SUFIX"
	NO_VERSION=1
fi

# Un cambio por tocar los óvalos.

if [ "$ARCH" == x86_64 ]; then
	echo "Downloading Flash Player to /tmp for 64 bits"
	wget -v http://download.macromedia.com/pub/labs/flashplayer10/flashplayer10_2_p3_64bit_linux_111710.tar.gz --directory-prefix="/tmp/Flashplayer.$DIR_ID_SUFIX"

	echo "unpacking Flash Player to /tmp"
	tar -xvf "/tmp/Flashplayer.$DIR_ID_SUFIX/flashplayer10_2_p3_64bit_linux_111710.tar.gz" -C "/tmp/Flashplayer.$DIR_ID_SUFIX"
	NO_VERSION=1
fi

if [ $NO_VERSION -eq 0 ]; then
	echo "Your kernel architecture isn't suported by Flash Player."
	echo "Not found: exiting"
	exit
fi
 
echo "installing Flash Player"
cp -va /tmp/Flashplayer.$DIR_ID_SUFIX/libflashplayer.so /usr/lib/mozilla/plugins
	
rm -rf /tmp/Flashplayer.$DIR_ID_SUFIX

echo "CONGRATULATION: FLASH PLAYER ALREADY INSTALLED"


