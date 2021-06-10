
#!/bin/sh

p=11
u=0
i=0
k=("sysAd_" "webDev_" "appDev_")
d=("sthirdJay" "sfourthJay" "wthirdJay" "wfourthJay" "athirdJay" "afourthJay")

while [ $u -le 5 ]
do
	groupadd ${d[$u]}
	u=`expr $u + 1`
done

u=`expr $u - 6`
while [ $p -le 31 ]
do
	if [ $p -eq 31 ];
	then
		sudo usermod -a -G ${d[$u]} "Jay_Jay"
		u=`expr $u + 1`
		if [ `expr $u % 2 ` -eq 0 -a $u -ne 6 ]
		then
			i=`expr $i + 1`
			p=`expr $p - 20`
		elif [ $u -eq 6 ]
		then
			break
		else
			p=`expr $p - 11`
		fi
	else
		sudo usermod -a -G ${d[$u]} "${k[$i]}$p"
	fi
	p=`expr $p + 1`
done

unset u
u=0
i=`expr $i - 3`
p=`expr $p - 20`
while [ $p -le 30 ]
do
	if [ $p -le 10 ]
	then
		if [ $p -eq 10 ]
		then
			sudo chgrp ${d[$u]} /home/"${k[$i]}$p"
			chmod 740 /home/"${k[$i]}$p"
			u=`expr $u + 1`
		else
			sudo chgrp ${d[$u]} /home/"${k[$i]}0$p"
			chmod 740 /home/"${k[$i]}0$p"
		fi
	elif [ $p -le 20 ]
	then
		sudo chgrp ${d[$u]} /home/"${k[$i]}$p"
		chmod 740 /home/"${k[$i]}$p"
	else
		sudo chgrp Jay_Jay /home/"${k[$i]}$p"
		chmod 740 /home/"${k[$i]}$p"
		if [ $p -eq 30 ]
		then
			u=`expr $u + 1`
			if [ $u -lt 5 ]
			then
				i=`expr $i + 1`
				p=`expr $p - 30`
			fi
		fi
	fi
	p=`expr $p + 1`
done


