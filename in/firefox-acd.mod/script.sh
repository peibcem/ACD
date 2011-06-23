#!/bin/bash - 
#===============================================================================
#
#          FILE:  script.sh
# 
#         USAGE:  ./script.sh 
# 
#   DESCRIPTION:  ACD module to install firefox(X)
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  Module for ACD
#        AUTHOR:  Luis S G (qwertyx), qwertylinuxdeb@gmail.com
#       COMPANY: 
#       CREATED: 07/05/11 19:23:09 CEST
#      REVISION:  ---
#===============================================================================

ARCH="`uname -m`"

if [ $ARCH != "x86_64" ]; then
	$ARCH = i686
fi

# Need to be logged as superuser
if [ `id -u` -ne 0 ]; then
	echo "firefox-acd module needs to be run as root"
	exit 1
fi

echo "Detected architecture is $ARCH"

wget -v -r -np http://releases.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-$ARCH/en-US/ --directory-prefix="/tmp"
tar -xvf /tmp/releases.mozilla.org/pub/mozilla.org/firefox/releases/latest/linux-$ARCH/en-US/firefox-*.tar.bz2 -C /usr/local/lib
if [ -e /usr/local/bin/firefox ]; then
	echo "File named /usr/local/bin/firefox already exits, deleting..."
	rm -rfv /usr/local/bin/firefox
fi

# Probably download of Firefox4 wasn't successfully
if [ -e /usr/local/lib/firefox/firefox ]; then
	ln -s /usr/local/lib/firefox/firefox /usr/local/bin/firefox
else
	echo "Error: Firefox hasn't been downloaded properly"
	exit 2
fi

# Clean
rm -rfv /tmp/releases.mozilla.org/
