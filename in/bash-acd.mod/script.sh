#!/bin/bash - 
#===============================================================================
#
#          FILE:  script.sh
# 
#         USAGE:  ./script.sh 
# 
#   DESCRIPTION:  ACD module for bash
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: YOUR NAME (), 
#       COMPANY: 
#       CREATED: 09/05/11 18:04:02 CEST
#      REVISION:  ---
#===============================================================================


I=`dirname $0`
TIME_ID=`date +%d_%m_%Y_%k_%M_%N`
USER_ID=`id -u`

# Backup if exits... [poor way :( ...]
if [ -e $HOME/.bashrc ]; then
	echo -n "$HOME/.bashrc already exits. "
	BACKUP_TIME_ID="$TIME_ID"
	cp -av $HOME/.bashrc $HOME/.bashrc_$BACKUP_TIME_ID
	echo "Backup in $HOME/.bashrc_$BACKUP_TIME_ID"
	rm -rfv $HOME/.bashrc
fi
if [ -e $HOME/.bash_profile ]; then
	echo -n "$HOME/.bash_profile already exits. "
	BACKUP_TIME_ID="$TIME_ID"
	cp -av $HOME/.bash_profile $HOME/.bash_profile_$BACKUP_TIME_ID
	echo "Backup in $HOME/.bash_profile_$BACKUP_TIME_ID"
	rm -rfv $HOME/.bash_profile
fi

# Files are different between a normal user and root.
if [ $USER_ID -eq 0 ]; then
	cp -v $I/box/bashrc_root $HOME/.bashrc
	cp -v $I/box/bash_profile_root $HOME/.bash_profile
else
	cp -v $HOME/box/bashrc_user $HOME/.bashrc
	cp -v $HOME/box/bash_profile_user $HOME/.bash_profile
fi

