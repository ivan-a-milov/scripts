#!/bin/bash

if [[ $# < 3 ]]
then
    echo "Usage: $0 <interval> <times> message"
    exit 0
fi

# timeout in seconds
hide_after=3

function kNotify()
{
    kdialog --passivepopup "$msg" $hide_after
}

function gNotify()
{
    notify-send --expire-time=$(( $hide_after * 1000 )) "$msg"
}

notifyCmd=

if which notify-send 1>/dev/null
then
    notifyCmd=gNotify
fi 

if which kdialog 1>/dev/null
then
    notifyCmd=kNotify
fi 

if [ -z $notifyCmd ] 
then
    echo "Can not figure out notify command"
    exit 2
fi

readonly INTERVAL=$1
if [[ ! $INTERVAL =~ ^[0-9]+$ ]]
then
    echo "Interval should be a number, got $INTERVAL"
    exit 3  
fi
shift

times=$1
if [[ ! $times =~ ^[0-9]+$ ]]
then
    echo "Times should be a number, got $times"
    exit 3  
fi
shift

(
    while [[ $times > 0 ]] ; do
        sleep $(( $INTERVAL * 60 ))
        msg="$(date +%H:%M:%S) :$*"
        $notifyCmd
        times=$(( $times - 1 ))
    done
) &

 
