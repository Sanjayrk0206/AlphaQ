
#!/bin/sh

i=1
p=0
d=("sysAd_" "webDev_" "appDev_")

while [ $i -le 30 ]
do
        if [ $i -lt 10 ]
        then
                ln -s /home/Jay_Jay/future.txt /home/"${d[$p]}0$i"/future.txt
        else
                ln -s /home/Jay_Jay/future.txt /home/"${d[$p]}$i"/future.txt
        fi
        if [ $p -lt 2 -a $i -eq 30 ];
        then
                i=`expr $i - 30`
                p=`expr $p + 1`
        fi
        i=`expr $i + 1`
done
