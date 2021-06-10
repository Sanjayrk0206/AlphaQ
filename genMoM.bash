
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

#'Read Loop' for creating ${date}_mom and insert random text
echo "Processing... Please Wait"
while read line
do
	FUser=`echo $line | cut -d " " -f 1` #reads User
	FDate=`echo $line | cut -d " " -f 3` #reads Date
	FDate=`echo $FDate | cut -d "," -f 1`
	if [ "$PFDate" != "$FDate" -a -n "$PFDate" ] #condition for output
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
			P=/home/"$LUser"/"$PFDate"_mom.txt
			if [ ! -f "$P" ]
			then
				echo
				echo $PFDate "done"
				< /dev/urandom tr -dc "[:space:][:print:]" | head -c10000 > /home/"$LUser"/"$PFDate"_mom.txt
			fi
			unset LUser
		fi
		unset Login
	else
		Login+=("$FUser") #append the required reading
	fi
	PFDate="$FDate"
done < $LOG

#for Last Date in the file as loop exits
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
	P=/home/"$LUser"/"$FDate"_mom.txt
	if [ ! -f "$P" ]
	then
		echo
		echo $FDate "done"
		< /dev/urandom tr -dc "[:space:][:print:]" | head -c10000 > /home/"$LUser"/"$FDate"_mom.txt
	fi
	unset LUser
fi
unset Login

