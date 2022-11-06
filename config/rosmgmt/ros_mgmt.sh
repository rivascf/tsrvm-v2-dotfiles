# bash/zsh ros and ros2 management and prompt support
# Copyright (C) 2022 J. Felipe Rivas Campos <rivascf@gmail.com>
# Distributed under the GNU General Public License, version 2.0.
#
# This script allows you to setup ROS (Noetic) or ROS2 (Galactic) enviroments and, see 
# ROS status in your prompt.
#
# The ROS or ROS2 version and status will be displayed only if is active 
# The %s token is the placeholder for the shown status.
#
# The prompt status always includes the current version name.
#
# If ps1_use_icons is true, NerdFonts are required to see prompt icons
#

# Functions

Color_Off='\033[0m'       # Text Reset
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BWhite='\033[1;37m'       # White

# ros_activate. Management function to enable ROS1 or ROS2 version
# Available options: noetic/ros1 or galactic/ros2

ros_activate () 
{

	local exit=$?
	case "$#" in
		0) echo "Es necesario indicar la distro de ROS o ROS2 que desea activar, opciones: ROS1, ROS2, NOETIC o GALACTIC."
			return $exit
			;;
		1) local target=$1
			;;
		*) return $exit
			;;
	esac

	if [ -z "${ROS_DISTRO+x}" ]; then
		case ${target^^} in
			"NOETIC"|"ROS1") source ~/.config/rosmgmt/ros_noetic_conf.bash
				;;
			"GALACTIC"|"ROS2") source ~/.config/rosmgmt/ros2_galactic_conf.bash
				;;
			*) echo -e "La distro ${BGreen}'$1'${Color_Off} no se encuentra instalada."; return $exit
				;;
		esac
	else
		echo -e "${BBlue}ROS ${ROS_DISTRO^}${Color_Off} ya se encuentra activo en esta terminal, no es posible activar ${BGreen}\"$target\"${Color_Off}."
		return $exit
	fi

	if [ -z "${ROS_DISTRO+x}" ]; then
		echo -e "${BYellow}Advertencia:${Color_Off} No fue posible activar ${BGreen}\"$target\"${Color_Off}, verifique la causa del error."
	else
		echo -e "${BBlue}ROS$ROS_VERSION${Color_Off} (${BWhite}${ROS_DISTRO^}${Color_Off}) está activo en ésta terminal!"
	fi

	return $exit
} 

# __ros_network. Helper function to get ROS Network configuration

__ros_network () 
{
	env | egrep "ROS_MASTER_URI|ROS_IP|ROS_HOSTNAME"
}

# __ros_print_env_vars. Helper function to get ROS environment variables 

__ros_print_env_vars ()
{
	env | egrep "ROS_.*=|PYTHONPATH|LD_LIBRARY|AMENT_PREFIX_PATH"
}

# __ros_split_path. Helper function to split ROS_PACKAGE_PATH environment variable into array

__ros_split_path () 
{
	set -f
        local IFS=: 
	local rp_arr=($ROS_PACKAGE_PATH)
	
	for indx in "${!rp_arr[@]}"; do echo "$indx ${rp_arr[$indx]}"; done

}

# __is_ros_running. Helper function to determinate if roscore is running and get PID 

__is_ros_running ()
{
	# if pidof -x "roscore" > /dev/null; 
	
	local rospid = echo $(ps -efww | grep -w "rosout" | grep -v grep | grep -v $$ | awk '{ print $2 }')

	# if $(pgrep rosout) ;
	if $(ps -efww | grep -w "rosout" | grep -v grep | grep -v $$ | awk '{ print $2 }') ;
	then
		echo "ROS is running on ($?)."
	else
		echo "ROS is not running."
	fi

	# if [[ -z pgrep -x "rosout" ]]; then
	#	echo "Running ($@)"
	# else
	#	echo "Stopped"
	# fi

	# local roscore_pid=${"ps -efww | grep -w "roscore" | grep -v grep | grep -v $$ | awk '{ print $2 }'"}
	# echo $roscore_pid

	# if [ ! -z [${roscore_pid}]]; then
	# 	return $roscore_pid
	# fi
}


# __ros_ps1_colorize_string. Helper function to colorize that is meant to be called by __ros_ps1.
# It injects color codes into the appropriate rosstring variables used to build ros_ps1_string. 
# Colored variables are responsible for cleaning their own color

__ros_ps1_colorize_string ()
{
	local rosdistro=$(rosversion -d)
	
	local c_clear='\033[0m'

	local c_l='\033[0;27m'

	# just for fun
	local c_d=$(
		case "$rosdistro" in 
			("melodic") echo "75" ;;
			("noetic") echo "73" ;;
			("foxy") echo "166" ;; 
			("galactic") echo "63" ;;
			("rolling") echo "40" ;;
			("humble") echo "74" ;;
			(*) echo "255" ;;
		esac
	)

	c_d="\033[0;${c_d}m"

	if [ -n "$l" ]; then
		l=$c_l$l$c_clear
		v=$c_l$v$c_clear
	fi
	if [ -n "$d" ]; then
		d=$c_d$d$c_clear
	fi
}


# __ros_ps1. Generate terminal prompt component if ROS1 or ROS2 are active

__ros_ps1 ()
{
	# preserve exit status
	local exit=$?
	local printf_format='(%s)'
	local ps1_use_icons=yes
	local show_colors=no

	case "$#" in
		0|1) printf_format="${1:-$printf_format}"
			;;
		*) return $exit
			;;
	esac

	# Format with logo, ROS 1
	# '\u283F'+'\u2807'+'${ROS_DISTRO^}'
	# Without logo
	# 'ROS'+'${ROS_DISTRO^}'
	# Format with logo, ROS2
	# '\u283F'+'\u2807'+'2'+'${ROS_DISTRO^}'
	# 'ROS'+'${ROS_DISTRO^}'
	# Without logo
	# 'ROS2'+'${ROS_DISTRO^}'
	
	local l=''
	local v=''
	local d=''

	if [ -z "${ROS_DISTRO+x}" ]; then
		return $exit
	else 
		if [ $ps1_use_icons = yes ]; then
			l=$'\u283F\u2807'
		else
			l='ROS'
		fi
		if [ -z "$ROS_VERSION" ]; then
			return $exit
		else
			v=${ROS_VERSION}
		fi
		d=${ROS_DISTRO^}
	fi


	if [ $show_colors = yes ]; then
		__ros_ps1_colorize_string
	fi

	local ps1_string="$l$v $d"
	
	printf -- "$printf_format" "$ps1_string"

	return $exit

}


