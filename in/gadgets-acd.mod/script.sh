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
#        AUTHOR: José Juan Ibáñez Cemborain "peibcem@gmail.com" (), 
#       COMPANY: 
#       CREATED: 28/06/11 20:57:40 CEST
#      REVISION:  ---
#===============================================================================

I=`dirname $0`

cp -v --preserve=mode $I/box/* /usr/local/bin

exit 0 

