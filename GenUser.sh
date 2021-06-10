
#!/bin/sh

i=1
p=0
d=("sysAd_" "webDev_" "appDev_")

while [ $i -le 30 ]
do
	if [ $i -lt 10 ]
	then
		useradd -m "${d[$p]}0$i"
		chmod 700 /home/"${d[$p]}0$i"
	else
		useradd -m "${d[$p]}$i"
		chmod 700 /home/"${d[$p]}$i"
	fi
	if [ $p -lt 2 -a $i -eq 30 ];
	then
		i=`expr $i - 30`
		p=`expr $p + 1`
	elif [ $p -eq 2 -a $i -eq 30 ];
	then
		useradd -m "Jay_Jay"
		chmod 700 /home/"Jay_Jay"
		p=`expr $p + 1`
	fi
	i=`expr $i + 1`
done

