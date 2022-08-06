## VENV auxiliary functions

# __venv_ps1. Helper function to overwrite default venv bash text from pyenv library
# showing python version when a venv has been activated

__venv_ps1 () 
{
	# Preserve exit status
	local exit=$?
	local use_icons=yes
	local printf_format='(%s)'
	local env_type=''

	case "$#" in 
		0|1) printf_format="${1:-$printf_format}"
			;;
		*) return $exit
			;;
	esac

	local v=''

    if [ -z ${VIRTUAL_ENV+x} ] && [ -z ${CONDA_DEFAULT_ENV+x} ]; then
	    return $exit
    else
		if [ -z ${CONDA_DEFAULT_ENV+x} ]; then
			env_type='Python'
		else
			env_type='Conda'
		fi
    fi

	if [ "$env_type" == "Python" ]; then
		v="$(python --version | awk '{print $2}')"
	else
		v="($CONDA_DEFAULT_ENV)"
	fi

	local ps1_string=''

	if [ $use_icons == yes ]; then
		if [ "$env_type" == "Conda" ]; then 
			ps1_string=" $env_type $v"
		else
			ps1_string=" v$v"
		fi
	else
		ps1_string="$env_type v$v"
	fi

	printf -- "$printf_format" "$ps1_string"

	return $exit
}
