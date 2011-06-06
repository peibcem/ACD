#!/bin/bash - 
#===============================================================================
#
#          FILE:  script.sh
# 
#         USAGE:  ./script.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: YOUR NAME (), 
#       COMPANY: 
#       CREATED: 15/05/11 17:43:34 CEST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#Need to be logged as superuser
if [ `id -u` -ne 0 ]; then
	echo "This module needs to be run as root"
	exit
fi

echo "I'm detecting which graphic card do you use, this probably will take a moment, be patient"

ARCH="`uname -m`"
NVIDIA=`hwinfo --short | grep "^graphics card" -A 1 | grep -i " nvidia " | wc -l`
ATI=`hwinfo --short | grep "^graphics card" -A 1 | grep -i " ati " | wc -l`
FAIL="Sorry, but I don't know what graphic card do you use. Poor you."

if [ $ARCH != "x86_64" ]; then
	$ARCH=x86
fi

while [ $ATI -eq 0 && $NVIDIA -eq 0 ]; do
	echo "$FAIL"
	read -p "You use ATI (0), nVidia (1), the both (2) or you just want to quit (3): (0/1/2/3) " WO

	case $WO in
		0 )
			let ATI=1
			;;
		1 )
			let NVIDIA=1
			;;
		2 )
			let ATI=1
			let NVIDIA=1
			;;
		3 )
			echo "Do what you want..."
			exit
			;;
		esac

	FAIL="Are you fucking kidding me?"
done

echo "Detected architecture is $ARCH"

if [ $ATI -eq 1 ]; then
	echo "I'll shall to download and install the driver for ATI graphic cards"
	wget -cv http://www2.ati.com/drivers/linux/ati-driver-installer-11-5-x86.x86_64.run --directory-prefix="/tmp/gcard"
	chmod a+x /tmp/gcard/*
	/tmp/gcard/*
	aticonfig --initial
fi	
	
if [ $NVIDIA -eq 1 ]; then
	echo "I'll shall to download and install the driver for nVidia graphic cards"
	wget -cv http://us.download.nvidia.com/XFree86/Linux-$ARCH/270.41.06/NVIDIA-Linux-$ARCH-270.41.06.run --directory-prefix="/tmp/gcard"
	chmod a+x /tmp/gcard/*
	/tmp/gcard/*
fi

rm -rf /tmp/gcard
