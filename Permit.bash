
#!/bin/bash

p_no=11 #variable for profile number like 01,02,...30
u=0 #variable for group array index
i=0 #variable for user array index
User=("sysAd_" "webDev_" "appDev_")
group=("sthirdJay" "sfourthJay" "wthirdJay" "wfourthJay" "athirdJay" "afourthJay")

#Checking and Creating Group
while [ $u -le 5 ];
do
	groupadd ${group[$u]} #Creates group if it does't exist
	u=`expr $u + 1`
done

#Adding Users to their Group Accordingly
u=`expr $u - 6`
while [ $p_no -le 31 ]
do
	if [ $p_no -eq 31 ]; #Adding 'Jay_Jay' in group
	then
		sudo usermod -a -G ${group[$u]} "Jay_Jay"
		u=`expr $u + 1` #Changing index of group array
		if [ `expr $u % 2 ` -eq 0 -a $u -ne 6 ] #Changing index of user array
		then
			i=`expr $i + 1`
			unset p_no
			p_no=11
		elif [ $u -eq 6 ] #Breaking the loop after everything is assigned
		then
			break
		else
			p_no=`expr $p_no - 10` #for repeatation of thirdJay and FourthJay
		fi
	else
		sudo usermod -a -G ${group[$u]} "${User[$i]}$p_no" #Adding for User profile_01...profile_20 accordingly
		p_no=`expr $p_no + 1`
	fi
done

#Adding group and Changing Permission accordingly
unset u
unset p_no
unset i
p_no=1 #variable for profile number like 01,02,...30
u=0 #variable for group array index
i=0 #variable for user array index
while [ $p_no -le 30 ]
do
	if [ $p_no -le 10 ]
	then
		if [ $p_no -eq 10 ] #Adding group and Changing permission of profile secondyear
		then
			sudo chgrp ${group[$u]} /home/"${User[$i]}$p_no"
			chmod 740 /home/"${User[$i]}$p_no"
			u=`expr $u + 1`
		else
			sudo chgrp ${group[$u]} /home/"${User[$i]}0$p_no" #Adding group and Changing permission of profile secondyear
			chmod 740 /home/"${User[$i]}0$p_no"
		fi
	elif [ $p_no -le 20 ]
	then
		sudo chgrp ${group[$u]} /home/"${User[$i]}$p_no" #Adding group and Changing permission of profile thirdyear
		chmod 740 /home/"${User[$i]}$p_no"
	else
		sudo chgrp Jay_Jay /home/"${User[$i]}$p_no" #Adding group and Changing permission of profile fourthyour
		chmod 740 /home/"${User[$i]}$p_no"
		if [ $p_no -eq 30 ]
		then
			u=`expr $u + 1` #Changing group index 
			if [ $u -lt 5 ]
			then
				i=`expr $i + 1` #Changing User index
				p_no=`expr $p_no - 30`
			fi
		fi
	fi
	p_no=`expr $p_no + 1`
done


