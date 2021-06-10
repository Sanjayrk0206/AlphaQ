
#!/bin/bash

LOG=attendence.log
declare -a User
declare -a Login

function Ini() {
        i=1 #variable for the profile like 01 .... 30
        p=0 #variable for 'd' array index
        d=("sysAd_" "webDev_" "appDev_")
        while [ $i -le 10 ]
        do
                if [ $i -le 10 ]
                then
                        User+=("${d[$p]}$i") #append the user list into user array
                else
                        User+=("${d[$p]}0$i") #append the user list into user array
                fi
                if [ $p -lt 2 -a $i -eq 10 ];
                then
                        i=`expr $i - 10`
                        p=`expr $p + 1`
                fi
                i=`expr $i + 1`
        done
}

Ini #Calling function for User array

#'Read Loop' for view ${date}_mom according to with and without parameter
GDate="$1"
endloop=0
EGDate=`date -d "$2 +1 days" "+%Y-%m-%d"`
echo "Processing... Please Wait"
until [ $endloop -eq 2 ]
do
        if [ -n "$GDate" ]
        then
                m=0
                while read line && [ $m -eq 0 ];
                do
                        FUser=`echo $line |  grep $GDate | cut -d " " -f 1`
                        FDate=`echo $line | cut -d " " -f 3`
                        FDate=`echo $FDate | cut -d "," -f 1`
                        if [ -n "$FUser" ]
                        then
                                Login+=("$FUser")
                        elif [ -z "$FUser" -a -n "${Login[0]}" ]
                        then
                                unset m
                                m=1
                        elif [ "$FDate" ">" "$GDate" -a -z "${Login[0]}" ]
                        then
                                unset m
                                m=1
                        elif [ "$FDate" = "$GDate" -a $endloop -eq 1 -a -z "$FUser" ]
                        then
                                unset m
                                m=1
                                endloop=`expr $endloop + 1`
			elif [ "$RDate" ">" "$FDate" ]
                                then
                                        unset m
                                        echo "======= $GDate does't exist ======"
                                        m=1
                                        endloop=`expr $endloop + 1`
                       	fi
                       	RDate="$FDate" #rough date to break the loop
                done < $LOG
        else
                unset GDate
                GDate="$(date '+%Y-%m-%d')"
                endloop=`expr $endloop + 1`
        fi
        if [ -n "${Login[0]}" ]
        then
		for i in "${Login[@]}"
                do
                        for l in "${!User[@]}"
                        do
                                if [ "${User[l]}" = "$i" ]
                                then
                                         LUser="$i"
                                fi
                        done
                done
                if [ -n "$LUser" ]
                then
			P=/home/Jay_Jay/"$GDate"_mom.txt
			if [ ! -f "$P" ]
			then
	                        ln -s /home/"$LUser"/"$GDate"_mom.txt /home/Jay_Jay/"$GDate"_mom.txt
			fi
                        unset LUser
                fi
                unsetgrep -q -E "^admin:" /etc/group Login
        fi
        unset m
        if [ -n "$2" ]
        then
                GDate=`date -d "$GDate +1 days" "+%Y-%m-%d"`
                if [ "$GDate" = "$EGDate" ]
                then
                        endloop=`expr $endloop + 2`
                fi
        fi
done
