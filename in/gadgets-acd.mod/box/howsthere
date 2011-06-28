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
#       CREATED: 18/06/11 14:33:45 CEST
#      REVISION:  ---
#===============================================================================

TIME="$2"
SAVE="$3"
REPEAT="0"

if [ -z "$TIME" ]; then
	echo "Fatal: time not ascribed."
	echo "whosthere [-t seconds] [-s to save in a file, -d to don't save] " 
	echo "if you choose save, it will save in /tmp/.registro"
	exit
fi

if [ -z "$SAVE" ]; then

	echo "whosthere [-t seconds] [-s to save in a file, -d to don't save]"
	echo "if you choose save, it will save in /tmp/.registro"
	exit
fi

if [ "$REPEAT" -eq "0" ]; then
	
	while [ "$SAVE" == "-s" ]; do

		if [ "$TIME" -gt "0" ]; then
			
			date>>/tmp/.registro
			date
			w>>/tmp/.registro
			w
			sleep $TIME
		fi
	done
fi

if [ "$REPEAT" -eq "0" ]; then
	
	while [ "$SAVE" == "-d" ]; do

		if [ "$TIME" -gt "0" ]; then

			date
			w
			sleep $TIME
		fi
	done
fi

echo "select a time >0 and if you want to save the registration"
echo "whosthere [-t seconds] [-s to save in a file, -d to don't save] " 
echo "if you choose save, it will save in /tmp/.registro"

exit



