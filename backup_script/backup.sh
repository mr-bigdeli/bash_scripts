#!/bin/bash
# https://github.com/mohrez021/bash_scripts/blob/main/backup_script/backup.sh

verbose=0
date_to_filename=""
backup_name=""

function HELP () {	
	cat <<EOL
USAGE: $0 [OPTIONS] <source_dir> <backup_name>
Options:
	-h		: Help
	-v		: Verbose
	-d <format>	: Add date to the end of backup file neme.
			  Supported Formats: "time", "date", "datetime", "timestamp"

EOL
	}




if [[ $# -lt 2 ]] && [[ "$1" != "-h" ]]; then
	HELP
	exit 1
fi

while true; do
	case $1 in
		-h)
			HELP
			exit 0
			;;

		-v)
			verbose=1
			shift 1
			;;
		-d)
			case $2 in
				time)
					date_to_filename=`date +%H%M%S`
					;;
				date)
					date_to_filename=`date +%Y%m%d`
					;;
				datetime)
					date_to_filename=`date +%Y%m%d-%H%M%S`
					;;
				timestamp)
					date_to_filename=`date +%s`
					;;
				*)
					echo "ERROR: Unsupported date format.("time", "date", "datetime", "timestamp")"
					exit 1
					;;

			
			esac
			shift 2
			;;
		*)
			break
			;;
	esac
done

if [[ $# -ne 2 ]]; then
	HELP
	exit 1
fi

if [[ "$2" != *.tar.gz ]]; then
	echo "ERROR: '$2' should be end with .tar.gz extension"
	exit 1
fi

if [[ -n "$date_to_filename" ]]; then
	backup_name="$2.$date_to_filename"
else
	backup_name=$2
fi


if [[ ! -d $1 ]]; then
	echo "ERROR: '$1' should be a directory"
	exit 1
fi

if [[ -e $backup_name ]]; then
	echo "ERROR: '$backup_name' is existed in this path, choose another backup name"
	exit 1
fi


if [[ $verbose -ne 0 ]]; then
		tar -zcvf $backup_name $1
else
		tar -zcf $backup_name $1 &> /dev/null
fi

if [[ ! -f $backup_name ]]; then
        echo "ERROR: couldn't create $backup_name"
	exit 1
else
	echo "$backup_name created successfully"
fi

