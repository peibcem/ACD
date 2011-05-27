#!/bin/bash - 
#===============================================================================
#
#          FILE:  aconfdeb.sh
#
#         USAGE:  ./aconfdeb.sh 
#
#   DESCRIPTION:  Main script of ACD.
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Luis S G (qwertyx), qwertylinuxdeb@gmail.com
#       COMPANY: No company.
#       CREATED: 05/05/11 20:04:27 CEST
#      REVISION:  ---
#===============================================================================
#

# Absolute path to main ACD directory. (Where is placed this script)
I=`dirname $0`

# :TODO:05/05/11 20:34:36 CEST:: Choose properly branch (throw arguments, lsb_release...etc)
DEBVERSION="testing" 

TIME_ID=`date +%d_%m_%Y_%k_%M_%N`

# to_inst_array contains all the modules which are going to be installed.
to_inst_array=(`find in -maxdepth 1 -name *-acd.mod -printf "%f\n"`)

# already_inst array will be used during dependencies check/install phase.
already_inst=()


#===  FUNCTION  ================================================================
#          NAME:  array_has
#   DESCRIPTION:  Return number of coincidences of an element in an array.
#    PARAMETERS:  1 ->	Array name. (Array _name_ where function is going to
#    			search)
#		  2 ->	Element to search. (String to search in Array_name[*])
#       RETURNS:  It returns number of coincidences found.
#===============================================================================
function array_has()
{
	array_name="$1"
	num_elements=${#array_name[*]}
	
	PRESENT=0

	# Primero ejectuta como una orden el concatenamiento de todos los argumentos pasados a eval
	# Pero ANTES de la ejecucion sustituye nombres de variables ($var), por valores de variables.
	# (El $ escapado, evidentemente no es sustituido por nada. Luego se encargara echo (cuando se
	# ejecute la orden) de mostrarlo. ( \ es eliminado por eval )

	for g in $(eval echo "\${${array_name}[*]}"); do
		if [ "$g" == $2 ]; then
			let PRESENT=$PRESENT+1
		fi
	done
				
	return $PRESENT
}


# :BUG:21/05/11 21:37:08 CEST::	Posible infinite loop around here..If A depend of
# 				B a B depend of A...zas!

#===  FUNCTION  ================================================================
#          NAME:  install_mod
#   DESCRIPTION:  This function will run script.sh inside $I/in/$mod_name/
#    PARAMETERS:  1 ->	Module's name. Something like.."vim-acd.mod" ($mod_name)
#       RETURNS:  Exit status of script run.
#===============================================================================
function install_mod()
{
	mod_name=$1

	array_has already_inst $mod_name
	if [ $? -gt 0 ]; then
		echo "Module $mod_name already installed (exiting...)"
		exit
	fi

	# Hasn't got any dependencies.
	if [ ! -s  $I/in/$mod_name/mod-dep ]; then
		# Run it.
		$I/in/$mod_name/script.sh
		to_return=$?

		# Add module's name to already_inst array.
		already_inst=( "${already_inst[@]}" "$mod_name" )
	else 
	# Has dependencies.
		for i in $(cat $I/in/$mod_name/mod-dep); do
			install_mod $i
		done
		# Now all dependencies are already installed, let's run it.
		$I/in/$mod_name/script.sh
		# Add module's name to already_inst array.
		already_inst=( "${already_inst[@]}" "$mod_name" )
	fi

	return $to_return
}



echo "Following modules are going to be installed: ${to_inst_array[@]}"
echo "They are ${#to_inst_array[@]}"
echo 
#ls -d $I/in/*-acd.mod

# Check if modules dependencies are OK.
# XXX All modules has to have at least a void mod-dep file. XXX
# For each mod-dep file of all modules install each "line"
# (Each line in mod-dep files contains a dependence of that module)
for a in $(ls $I/in/*-acd.mod/mod-dep); do
	echo "Processing: $a"
	for b in $(cat $a); do
		# If there are no dependencies in module, ignore it.
		if [ ! -s $a ]; then
			echo "Module `basename $(dirname $a)` hasn't got any dependencies."
			break
		fi
		
		# Check if any dependence is going to be installed.
		array_has to_inst_array $b
		if [ $? -eq 0 ]; then
			echo "Module \"$b\" isn't present in \"in/\" directory. \"$b\" is required by \"$a\"."
			echo "Install it before trying again run this script"
			exit
		fi
	done
done

# Install packages phase. (Required by modules and general packages)
if [ -a /etc/apt/sources.list ]; then
	BACKUP_TIME_ID=$TIME_ID
	cp -av "/etc/apt/sources.list" "/etc/apt/sources.list.$BACKUP_TIME_ID"
	echo "/etc/apt/sources.list saved at /etc/apt/sources.list.$BACKUP_TIME_ID"
	rm /etc/apt/sources.list
fi

cp -v $I/versions/$DEBVERSION/sources.list /etc/apt/sources.list

# :TODO:05/05/11 20:48:22 CEST:: Could be a little bit aggressive :d
echo "Upgrading packages..."
aptitude update --visual-preview && aptitude upgrade --visual-preview

echo "Now, a list of packages will be installed. Modules required packages will be also installed."
echo "You can select which one it's going to be installed and which is not."
sleep 15
aptitude install --visual-preview `cat $I/in/packages.list` `cat $I/in/*-acd.mod/packages`

# These packages ($I/in/*-acd.mod/packages) are absolutely necessary to be installed, cause
# modules need them. They have to be installed if they were not (in previous aptitude command).
# With previous aptitude order you can install all of them in just one step. Doing it at night :)
aptitude install `cat $I/in/-acd.mod/packages`

# Install modules phase.
for e in $(ls -d $I/in/*-acd.mod); do
	echo "Next module to install: `basename $e`"
	install_mod "`basename $e`"	# Note the basename command...
done

