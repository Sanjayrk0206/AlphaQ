
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

echo "Processing... Please Wait"
while read line
do
	p=`echo $line | cut -d " " -f 1`
	q=`echo $line | cut -d " " -f 3`
	q=`echo $q | cut -d "," -f 1`
	if [ "$r" != "$q" -a -n "$r" ]
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
			P=/home/"$h"/"$r"_mom.txt
			if [ ! -f "$P" ]
			then
				echo
				echo $r "done"
				< /dev/urandom tr -dc "[:space:][:print:]" | head -c10000 > /home/"$h"/"$r"_mom.txt
			fi
			unset h
		fi
		unset Login
	else
		Login+=("$p")
	fi
	r="$q"
done

for i in "${Login[@]}"
do
       for l in "${!User[@]}"
       do
              if [ "${User[l]}" = "$i" ]
              then
		    echo $i
		    h="$i"
              fi
       done
done
if [ -n "$h" ]
then
	P=/home/"$h"/"$q"_mom.txt
	if [ ! -f "$P" ]
	then
		echo
		echo $q "done"
		< /dev/urandom tr -dc "[:space:][:print:]" | head -c10000 > /home/"$h"/"$r"_mom.txt
	fi
	unset h
fi
unset Login

