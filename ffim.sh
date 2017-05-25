
#!/bin/bash

# TODO operate on default instance (process with no -P option)
# TODO bash-complition 

DBG_FLAG=false

function usage()
{
    # TODO add init command for initialization of new empty profile
    echo "FireFox Instance Manager"
    echo "usage: ffim [list-profiles|status|up|stop|cont|down] [profileName1] [profileName2] ... "
    echo "       ffim manage"
}


function echoPIDbyProfile()
{
    if [ ! -z $1 ]
    then
        profile=$1
        PID=$( ps h -C firefox -o pid,cmd | grep $profile | awk -e '{ print $1 }' )
        pids_count=$( echo $PID | wc -w )
        case $pids_count in
            0) ;;
            1)
                echo $PID
                ;;
            2)
                echo "Two instaces of $profile, working with first" 1>&2
                echo $PID | awk -e '{ print $1 }'

                ;;
            *)
                echo "$profile is a way too strange" 1>&2
                exit 1
                ;;
        esac
#         echo -e "\n\t\tPID: $PID\tprofile: $profile" 1>&2
    else
        echo -e "\n\t--- Error: echoPIDbyProfile require profile name as argument ---" 1>&2
    fi
}

function echoStatusByPID()
{
    if [ ! -z $1 ]
    then
        stat_code=$( ps h -p $1 -o stat | head -c 1 )
#        echo "          --- stat code: $stat_code "
        case $stat_code in
            "T")
                echo SLEEPING
                ;;
            "S" | "R" )
                echo RUNNING
                ;;
            *)
                echo IN_TROUBLE
                ;;
        esac
    else
        echo -e "\n\t--- Error: echoPIDbyProfile require PID name as argument ---" 1>&2
    fi
}

function status()
{
    profile=$1
    $DBG_FLAG && echo "Getting status of $profile"

    status=DOWN
    pid=$( echoPIDbyProfile $profile )
    [ ! -z $pid ] && status=$( echoStatusByPID $pid )
    printf "%-15s%20s" $profile $status 
    [ ! -z $pid ] && printf " (%6d)" $pid
    echo
}

function killProfile()
{
    if [ ! -z $1 ]
    then
        pid=$( echoPIDbyProfile $1 )
        [ ! -z "$pid" ] && ( kill -CONT $pid ; kill $2 $pid )
    else
        echo -e "\n\t--- Error: killProfile require profile name as argument ---"
        exit 1
    fi
}

function up()
{
    profile=$1

    pid=$( echoPIDbyProfile $profile )
    if [ ! -z $pid ]
    then
        echo -e "\n\t--- Error: $profile is already up ---" 1>&2
        exit 1
    fi

    $DBG_FLAG && echo "Fireing UP $profile"
    if [ ! -z $profile ]
    then
        cmd="firefox --new-instance -P $profile"
        $cmd &

        # sleep 10
        # pid=$( echoPIDbyProfile $profile )
        # echo $pid
        # for id in $( xwininfo -root -children | grep -oP '0x([0-9a-f]){5,}+' )
        # do
        #     count=$( xprop -id $id _NET_WM_PID | grep -w $pid | wc -l );
        #     if [[ "$count" == "1" ]]
        #     then
        #         echo xprop -id $id -f WM_COMMAND 8s -set WM_COMMAND "$cmd"
        #         xprop -id $id -f WM_COMMAND 8s -set WM_COMMAND "$cmd"
        #     fi
        # done


    else
        echo -e "\n\t--- Error: up require profile name as argument ---" 1>&2
        exit 1
    fi
}

function stop()
{
    profile=$1
    $DBG_FLAG && echo "Stopping $profile"
    killProfile $profile -STOP
}

function cont()
{
    profile=$1
    $DBG_FLAG && echo "Continuing $profile"
    killProfile $profile -CONT
}

function down()
{
    profile=$1
    $DBG_FLAG && echo "Putting down $profile"
    killProfile $profile
}



if [[ $# == 0 ]]
then
    $DBG_FLAG && echo "No args"
    usage
    exit 0
fi

readonly CMD=$1 ; shift
PROFILES=$*
readonly PROFILES_ALL=$( cat $HOME/.mozilla/firefox/profiles.ini | grep ^Name= | cut -f 2- -d= | tr '\n' ' ' )

case "$CMD" in
    list-profiles)
        echo $PROFILES_ALL | xargs -n1
        ;;
    manage)
        firefox --new-instance -P & 
        exit 0
        ;;
    status | up | stop | cont | down )
        ;;
    *)
        $DBG_FLAG && echo "Wrong command"
        usage
        exit 1
esac

for p in $PROFILES
do
    # Note the surraunding spaces. It makes word-match instead of just substring.
    if [[ ! " $PROFILES_ALL " =~ " $p " ]]
    then
        echo "Wrong profile name: $p"
        exit 2
    fi
done

[ -z "$PROFILES" ] && PROFILES=$PROFILES_ALL

for p in $PROFILES
do
    $CMD $p
done

