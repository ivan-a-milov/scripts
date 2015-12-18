#!/bin/bash

if [[ $# < 3 ]]
then
    echo "Usage: $0 <interval> <times> message"
    exit 0
fi

readonly INTERVAL=$1
shift

times=$1
shift

(
    while [[ $times > 0 ]] ; do
        sleep $(( $INTERVAL * 60 ))
        kdialog --passivepopup "$(date +%H:%M:%S) :$*" 300
        times=$(( $times - 1 ))
    done
) &
 
