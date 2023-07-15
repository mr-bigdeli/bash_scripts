#!/bin/bash

VERBOSE=0
NUM=5
INTERVAL=10

help() {
	cat <<EOF
Usage: $0 [OPTIONS]...COMMAND
Available options:
  -h: Show help of this command and exit.
  -v: Verbose mode
  -n: Number of tries (threashold) (Default: 5)
  -i: Interval seconds between tries (Default: 10)
Examples:
  $0 -v COMMAND
  $0 -v -n 3 -i 2 COMMAND
  $0 -v -i 5 COMMAND
  $0 -i 5 -n 2 COMMAND
EOF
}

# check arguman is number (for interval and threshold)
check_number() {
	if [[ "$1" =~ ^[0-9]+$ ]]; then		# regex for matching digits(number)
		return 0
	else
		return 1
	fi
}

# age arguman vared nakard moghe ejra help neshoon bede
if [[ $# -eq 0 ]]; then
	help
	exit
fi

# ta vaghti arguman voroodi darim halghe ejra she
while [[ $# -ne 0 ]]; do
	case $1 in 
		"-h")
			help
			exit
			;;
		"-v")
			VERBOSE=1
			shift
			;;
		"-n")
			# check $2 is number
			check_number $2
			if [[ $? -ne 0 ]]; then
				help
				exit 1
			fi
			NUM=$2
			shift 2
			;;
		"-i")
			# check $2 is number
			check_number $2
			if [[ $? -ne 0 ]]; then
				help
				exit 1
			fi
			INTERVAL=$2
			shift 2
			;;
		*)
			# har chi dar edame zad user be onvane command ba arguman hash begir 
			COMMAND=$@
			#break yadet nare
			break
			;;
	esac
done

# age toole reshteie COMMAND sefr bood , bia biroon va help neshoon bede
if [[ -z $COMMAND ]]; then
	help
	exit 0
fi

for i in $(seq $NUM); do
	$COMMAND
	if [[ $? -eq 0 ]]; then
		SUCCESS=0
		break
	else
		if [[ $VERBOSE -eq 1 ]]; then
			echo "[INFO] Try $i failed. Sleep for $INTERVAL seconds..."
		fi
		SUCCESS=1
		sleep $INTERVAL
	fi
done

if [[ $SUCCESS -eq 0 ]]; then
	if [[ $VERBOSE -eq 1 ]]; then
		echo "[INFO] Command got executed successfully"
	fi
	exit 0
else
	if [[ $VERBOSE -eq 1 ]]; then
		echo "[ERROR] Threshold is reached and command operation failed."
	fi
	exit 1
fi
