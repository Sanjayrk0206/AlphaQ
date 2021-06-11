
#!/bin/bash

p_no=1 #variable for profile number like 01 ..... 30
i=0 #variable for 'User' Array index
User=("sysAd_" "webDev_" "appDev_")

#Creating and linking future.txt in all User's Home directory
while [ $p_no -le 30 ]
do
        if [ $p_no -lt 10 ] 
        then
                L=/home/"${User[$i]}0$p_no"/future.txt
                if [ ! -f "$L" ] #checks file exist or not
                then
                        ln -s future.txt /home/"${User[$i]}0$p_no"/future.txt #linking statement
                fi
        else
                L=/home/"${User[$i]}$p_no"/future.txt
                if [ ! -f "$L" ] #checks file exist or not
                then
                        ln -s future.txt /home/"${User[$i]}$p_no"/future.txt #linking statement
                fi
        fi
        if [ $i -lt 2 -a $p_no -eq 30 ]; #Changing User index accordingly
        then
                p_no=`expr $p_no - 30`
                i=`expr $i + 1`
        fi
        p_no=`expr $p_no + 1`
done

ln -s future.txt /home/Jay_Jay/future.txt
