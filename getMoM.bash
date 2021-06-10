
#!/bin/bash

LOG=attendence.log
declare -a User
declare -a Login

function Ini() {
        i=1
        p=0
        d=("sysAd_" "webDev_" "appDev_")
        while [ $i -le 10 ]
        do
                if [ $i -le 10 ]
                then
                        User+=("${d[$p]}$i")
                else
                        User+=("${d[$p]}0$i")
                fi
                if [ $p -lt 2 -a $i -eq 10 ];
                then
                        i=`expr $i - 10`
                        p=`expr $p + 1`
                fi
                i=`expr $i + 1`
        done
}

Ini
terminal=`tty`

exec < $LOG

j="$1"
h=0
b=0
m=0
g=0
z=`date -d "$2 +1 days" "+%Y-%m-%d"`
echo "Processing... Please Wait"
until [ $g -eq 2 ]
do
        if [ -n "$j" ]
        then
                while read line && [ $m -eq 0 ];
                do
                        p=`echo $line |  grep $j | cut -d " " -f 1`
                        q=`echo $line | cut -d " " -f 3`
                        q=`echo $q | cut -d "," -f 1`
                        if [ -n "$p" ]
                        then
                                Login+=("$p")
                        elif [ -z "$p" -a -n "${Login[0]}" ]
                        then
                                unset m
                                m=1
                        elif [ "$q" ">" "$j" -a -z "${Login[0]}" ]
                        then
                                unset m
                                m=1
                        elif [ "$q" = "$j" -a $g -eq 1 -a -z "$p" ]
                        then
                                unset m
                                m=1
                                g=`expr $g + 1`
                        fi
                done
        else
                unset j
                j="$(date '+%Y-%m-%d')"
                g=`expr $g + 1`
        fi
        if [ -n "${Login[0]}" ]
        then
		for i in "${Login[@]}"
                do
                        for l in "${!User[@]}"
                        do
                                if [ "${User[l]}" = "$i" ]
                                then
                                         h="$i"
                                fi
                        done
                done
                if [ -n "$h" ]
                then
			P=/home/Jay_Jay/"$j"_mom.txt
			if [ ! -f "$P" ]
			then
	                        ln -s /home/"$h"/"$j"_mom.txt /home/Jay_Jay/"$j"_mom.txt
			fi
                        unset h
                fi
                unset Login
        fi
        unset m
        m=0
        if [ -n "$2" ]
        then
                j=`date -d "$j +1 days" "+%Y-%m-%d"`
                if [ "$j" = "$z" ]
                then
                        g=`expr $g + 2`
                fi
        fi
done
