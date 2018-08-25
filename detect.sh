#! /bin/bash
clear

# VARS
baudrate=9600
ttyLocation=/dev/ttyACM0
outputFile=/home/pi/distances.txt
timeLogs=/home/pi/alertTimes.txt

distanceToAction=10

# Detect dependences

for i in ttylog curl
do
	if ! [ -x "$(command -v $i)" ]; then
	  echo "Error: $i is not installed." >&2
	  exit 1
	fi
done

#######################

if [ $# -eq 1 ]
then
	if [ "$1" == "start" ]
	then

		echo "Starting..."
		echo "Baud Rate: $baudrate"
		echo "TTY: $ttyLocation"

		ttylog -b $baudrate -d $ttyLocation -f >> $outputFile &

		while true
		do
			# Getting LastDistanceEntry

			lastDistance=`tail -n1 $outputFile`
		        if [ $lastDistance -gt $distanceToAction ]
			then
			curl -X POST -d "action=power&secretToken=25082018&power=off&bulbs=0x000000000451faeb" http://192.168.1.121/api.php
			echo "DISTANCE: $lastDistance"
			echo `date` >> $timeLogs
			else
			curl -X POST -d "action=power&secretToken=25082018&power=on&bulbs=0x000000000451faeb" http://192.168.1.121/api.php
			fi
		done

	elif [ "$1" == "stop" ]
	then

	echo "Stopping..."
	kill `pidof ttylog`
	echo "Killed!"
	else

	echo "Use start or stop as second parameter"
	fi


else
	echo "HELP"
	echo "- start: start calculating distance"
	echo "- stop: stop this script"
fi
