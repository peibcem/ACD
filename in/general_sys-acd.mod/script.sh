#!/bin/bash - 
#===============================================================================
#
#          FILE:  script.sh
# 
#         USAGE:  ./script.sh 
# 
#   DESCRIPTION:  This script will setup general system configuration.
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Luis S G (qwertyx), qwertylinuxdeb@gmail.com
#       COMPANY: No Company
#       CREATED: 28/05/11 14:30:17 CEST
#      REVISION:  ---
#===============================================================================

I="`dirname $0`"
TIME_ID_BACKUP="`date +%d_%m_%Y_%k_%M_%N`"

files_tosetup=(	"/etc/default/rcS"
		"/etc/profile"
		"/etc/inittab")

echo "${#files_tosetup[*]} files are going to be installed:"
echo "${files_tosetup[*]}"

for file_path in ${files_tosetup[*]}; do
	if [ -e "$file_path" ]; then
		cp  --preserve=mode,timestamps -vr "$file_path" "`dirname $file_path`/.`basename $file_path`.$TIME_ID_BACKUP"
		echo "File $file_path saved at `dirname $file_path`/.`basename $file_path`.$TIME_ID_BACKUP"

	fi
	cp -v "$I/box$file_path" "$file_path"
done
