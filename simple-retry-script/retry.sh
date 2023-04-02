#!/usr/bin/bash

re='^[0-9]+$'
VERBOSE=0
NUM=5
INTERVAL=10

help() {
    cat <<EOL
Usage: $0 [OPTIONS] COMMAND
Available options:
  -h: Show this help output
  -v: Verbose mode
  -n: Number of tries (default: 5)
  -i: Interval seconds (default: 10)
Examples:
  $0 -v COMMAND
  $0 -v -n 3 -i 2 COMMAND
  $0 -v -i 5 COMMAND
  $0 -i 5 -n 2 COMMAND
EOL
}

function check_number {
    if [[ $1 =~ $re ]]; then
        return 0
    else
        help
        exit 1
    fi
}

if [[ $# -eq 0 ]]; then
    help
    exit 0
fi

while [[ $# -ne 0 ]]; do
    case $1 in
        -v)
            VERBOSE=1
            shift
            ;;
        -h)
            help
            exit 0
            ;;
        -n)
            NUM=$2
            check_number $NUM
            shift 2
            ;;
        -i)
            INTERVAL=$2
            check_number $INTERVAL
            shift 2
            ;;
        *)
            COMMAND=$@
            break
            ;;
    esac
done

if [[ -z $COMMAND ]]; then
    help
    exit 0
fi

for i in $(seq 1 $NUM); do
    $COMMAND
    if [[ $? -eq 0 ]]; then
        if [[ $VERBOSE -eq 1 ]]; then
            echo "[INFO] $COMMAND got executed successfully"
        fi
         exit 0
    else
        if [[ $VERBOSE -eq 1 ]]; then
            if [[ $i -eq $NUM ]]; then
                echo "[ERROR] Try $i failed. Threshold reached and $COMMAND operation failed."
                exit 1
            fi
            echo "[INFO] Try $i failed. sleep for $INTERVAL seconds..."
        fi
        sleep $INTERVAL

    fi
done
