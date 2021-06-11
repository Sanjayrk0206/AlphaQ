
#!/bin/bash

#Creating User

i=1   #variable of while loop and for profile number like 01 02 ..... 30
p=0	  #variable for 'User' array index
User=("sysAd_" "webDev_" "appDev_")

if [ ! -d "/home" ] #Checks for directory "/home" exists
then
	mkdir "/home"   # Created directory "/home" if it does't exist
fi

while [ $i -le 30 ]
do
	if [ $i -lt 10 ]
	then
		useradd -m "${User[$p]}0$i" #Creates User
		chmod 700 /home/"${User[$p]}0$i" #Changing the default permission
	else
		useradd -m "${User[$p]}$i" #Creates User
		chmod 700 /home/"${User[$p]}$i" #Changing the default permissiom
	fi
	if [ $p -lt 2 -a $i -eq 30 ]; #Changing index of 'User' array
	then
		i=`expr $i - 30`
		p=`expr $p + 1`
	elif [ $p -eq 2 -a $i -eq 30 ]; #Changing index of 'User' array
	then
		useradd -m "Jay_Jay"	#Creates User account for the head "Jay_Jay"
		chmod 700 /home/"Jay_Jay" #Changing "Jay_Jay" default permission
		p=`expr $p + 1`
	fi
	i=`expr $i + 1`
done

