#!/bin/sh
#usage: wait.sh pid run.sh
#used to wait the pid to finish, then submit run.sh

if [ $# == 0  ]; then
  echo "usage: wait.sh pid run.sh"
  echo "used to wait the pid to finish, then submit run.sh"
else 
  while true; do
    if ! ps -p $1 > /dev/null 2>&1; then
	echo "PID $1 finished!" >&2
	bash $2
    	break
    else
    	sleep 120
    fi
  done
fi
