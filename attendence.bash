
#!/bin/bash

LOG=attendence.log

#array needed to find the absentees
declare -a User
declare -a Login

function Ini() {
	i=1 #variable for the profile like 01 .... 30
	p=0 #variable for 'd' array index
	d=("sysAd_" "webDev_" "appDev_")
	while [ $i -le 30 ]
	do
	        if [ $i -lt 10 ]
	        then
	                User+=("${d[$p]}0$i") #append the user list into user array
	        else
	                User+=("${d[$p]}$i") #append the user list into user array
	        fi
	        if [ $p -lt 2 -a $i -eq 30 ];
	        then
	                i=`expr $i - 30`
	                p=`expr $p + 1`
	        fi
	        i=`expr $i + 1`
	done
}

Ini #Calling function for User array

Gdate="$1" #First parameter
endloop=0 #Used for loop as there is two cases with and without parameter
EGdate=`date -d "$2 +1 days" "+%Y-%m-%d"` #Second parameter
echo "Processing... Please Wait"
until [ $endloop -eq 2 ]
do
	if [ -n "$Gdate" ] #check whether parameter is assigned or not
        then
			m=0
	        	while read line && [ $m -eq 0 ];           #Read date from the file
			do
				FUser=`echo $line |  grep $Gdate | cut -d " " -f 1`
				FDate=`echo $line | cut -d " " -f 3`
				FDate=`echo $FDate | cut -d "," -f 1`
				if [ -n "$FUser" ]
				then
					Login+=("$FUser") #append the required reading
				elif [ -z "$FUser" -a -n "${Login[0]}" ] #condition for end the loop
				then
					unset m
					m=1
				elif [ "$FDate" ">" "$Gdate" -a -z "${Login[0]}" ] #condition for end the loop
				then
					unset m
					m=1
				elif [ "$FDate" = "$Gdate" -a $endloop -eq 1 -a -z "$FUser" ] #condition for end the loop
                		then
                    			unset m
                   			m=1
					endloop=`expr $endloop + 1`
				elif [ "$RDate" ">" "$FDate" ]
				then
					unset m
					echo "======= $Gdate does't exist ======"
                   			m=1
					endloop=`expr $endloop + 1`
				fi
				RDate="$FDate" #rough date to break the loop
        		done < $LOG
	else				#parameters are not assigned
		unset Gdate
		Gdate="$(date '+%Y-%m-%d')"
		endloop=`expr $endloop + 1`
	fi
    if [ -n "${Login[0]}" ]
    then
		unset h
		h=0
		unset b
		b=0
		for i in "${Login[@]}"
		do
	                for l in "${!User[@]}"
			do
				if [ "${User[l]}" = "$i" ]
				then
					unset -v 'User[l]' #delete the value from User array
				else
					b=`expr $b + 1`
				fi
				h=`expr $h + 1`
			done
		done
		unset Login
		if [ $b -ne $h ]	#execute the output
		then
			echo
			echo "------ Absentees of $Gdate -------------"
			for l in "${User[@]}"
			do
				echo $l
			done
			if [ $endloop -eq 1 ]
			then
				break
			fi
			unset User
			Ini
		fi
	fi
	unset m #for read loop
	if [ -n "$2" ]
	then
		Gdate=`date -d "$Gdate +1 days" "+%Y-%m-%d"` #Change the Date
		if [ "$Gdate" = "$EGdate" ]
		then
			endloop=`expr $endloop + 2` #to end loop
		fi
	fi
done
