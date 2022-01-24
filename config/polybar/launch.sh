#!/usr/bin/env bash

## Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

outputs=$(xrandr --query | grep " connected" | cut -d" " -f1)
set -- $outputs
tray_output=$1

 	for m in $outputs; do
    		if [ $m == $1 ] 
    		then		
    			MONITOR1=$m polybar --reload default -c ~/.dotfiles/config/polybar/config &	
    		elif [ $m == $2 ]
    		then
    		    tray_output=$m
    			MONITOR2=$m polybar --reload right -c ~/.dotfiles/config/polybar/config &
    		else
    			MONITOR1=$m polybar --reload default -c ~/.dotfiles/config/polybar/config &
    	  fi
        done

    for m in $outputs; do
      	export MONITOR1=$1
      	export MONITOR2=$2
       	export TRAY_POSITION=none
        if [[ $m == $tray_output ]]; then
           TRAY_POSITION=right
      fi
    done

echo "Bars launched..."
