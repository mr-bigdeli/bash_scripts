This is just a small script to retry a command.
Usage: ./retry.sh [OPTIONS] COMMAND
Available options:
  -h: Show this help output
  -v: Verbose mode
  -n: Number of tries (default: 5)
  -i: Interval seconds (default: 10)
Examples:
  ./retry.sh -v COMMAND
  ./retry.sh -v -n 3 -i 2 COMMAND
  ./retry.sh -v -i 5 COMMAND
  ./retry.sh -i 5 -n 2 COMMAND
