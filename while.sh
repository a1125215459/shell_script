while [ true ]
do
sr 'a=`ifconfig |grep eth1 -A1 |grep inet`;if [ -z $a ];then echo "failed";else echo "succ";fi;reboot'
sleep 180
date
done
