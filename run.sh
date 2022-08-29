#! /bin/bash
#出厂版本设置
version="2.0.8"
echo "设置出厂版本为："
echo $version;
echo "1.断电保护--校验power_off_protect--存在"
echo "2.断电保护--.update_poweroff_flag--存在
断电保护--.update_poweroff_flag重启后被删除"
echo "3.断电保护--.update_poweroff_flag--不存在"
echo "4.通电初始化--/jffs2/bin下编写一个可执行的accelbox_init.sh脚本"
echo "5.通电初始化--校验accelbox_init.sh脚本"
echo "6.通电初始化--/jffs2/bin下编写一个无可执行权限的accelbox_init.sh脚本"
echo "7.通电初始化--目录包含accelbox文件夹，但不包含ams/agent内容"
echo "8.通电初始化--目录包含accelbox文件夹,但ams/agent无执行权限"
echo "9.通电初始化--目录不包含accelbox，但包含accelbox_bak"
echo "10.通电初始化--accelbox_bak还原为accelbox发生异常"
echo "11.通电初始化--校验/opt/gamebox中包含accelbox.tar.gz"
echo "12.通电初始化--/jjfs2不包含accelbox/accelbox_bak"
echo "13.reset键--校验/opt/gamebox/bin/recover脚本存在"
echo "14.升级前准备--通电之后检查accel_guard/ams/agent进程"
echo "15.升级前准备--中断ams/agent进程后拉起(accel_guard正常)"
echo "16.待accel_guard拉起修复后备用"
echo "17.更新--下载完成后，查看update文件内容存在"
echo "18.更新--下载完成后，查看下载包是否存在"
echo "19.更新--校验update.sh脚本存在"





while [ true ]
do
read -p "请输入想要运行的脚本:" num

case $num in
1)
echo "1.断电保护--校验power_off_protect存在"
sr '
a=`ls /opt/gamebox/bin/power_off_protect.sh |wc -l`;
if [ $a -eq 1 ];then echo "power_off_protect.sh exists";
echo "1.断电保护--校验power_off_protect存在--通过" >> /jffs2/result.txt;
fi'
;;
2)
echo "2.断电保护--update_poweroff_flag--存在"
sr 'cd /jffs2;sh xy 4'
sleep 60
sr 'cd /jffs2;
touch .update_poweroff_flag;
cp -R accelbox accelbox_bak;
echo '2.0.17' > accelbox_bak/version;
reboot'
sleep 150
sr '
a=`cat /jffs2/accelbox/version`;
if [ $a = '2.0.17' ];then
echo "2.断电保护--update_poweroff_flag--存在--通过"  >> /jffs2/result.txt;
fi'
sr '
a=`ls -a /jffs2/.update_poweroff_flag |wc -l`;
if [ $a -eq 0 ];then
echo "4.断电保护--update_poweroff_flag--重启后被删除--通过"  >> /jffs2/result.txt;
fi'
;;
3)
echo "3.断电保护--update_poweroff_flag--不存在"
sr 'cd /jffs2;sh xy 4'
sleep 60
sr 'cd /jffs2;
cp -R accelbox accelbox_bak;
echo '2.0.17' > accelbox_bak/version;
reboot'
sleep 150
sr '
a=`cat /jffs2/accelbox/version`;
if [ $a = '2.0.11' ];then
echo "3.断电保护--update_poweroff_flag--不存在--通过"  >> /jffs2/result.txt;
fi'
;;
4)
echo "4.通电初始化--编写可执行accelbox_init.sh"
sr 'cd /jffs2;sh xy 4'
sleep 60
sr '
rm -r /jffs2/accelbox_bak;
cd /jffs2/bin;
echo "echo 'sss' > /jffs2/test.log" > /jffs2/bin/accelbox_init.sh;
chmod +x accelbox_init.sh;
rm -r /jffs2/accelbox;
reboot'
sleep 150
sr '
a=`ls /jffs2/accelbox |wc -l`;
b=`ls /jffs2/test.log |wc -l`;
if [ $a -eq 0 ];then
echo "4.通电初始化--编写可执行accelbox_init.sh用例通过"  >> /jffs2/result.txt;
rm /jffs2/test.log;
rm /jffs2/bin/accelbox_init.sh;
fi'
;;
5)
echo "5.通电初始化--校验accelbox_init.sh脚本"
sr 'cd /jffs2;sh xy 4'
sleep 60
sr '
a=`ls /opt/gamebox/bin/accelbox_init.sh |wc -l`;
if [ $a -eq 1 ];then
echo "5.通电初始化--校验accelbox_init.sh脚本用例通过" >> /jffs2/result.txt;
fi'
;;
6)
echo "6.通电初始化--/jffs2/bin下编写一个无可执行权限的accelbox_init.sh脚本"
sr 'cd /jffs2;sh xy 4'
sleep 60
sr '
rm -r /jffs2/accelbox_bak;
rm /jffs2/bin/accelbox_init.sh;
echo "echo 'sss' > /jffs2/test.log" > /jffs2/bin/accelbox_init.sh;
rm -r /jffs2/accelbox;
reboot'
sleep 150
sr '
a=`ls /jffs2/accelbox |wc -l`;
if [ $a -ne 0 ];then
echo "6.通电初始化--/jffs2/bin下编写一个无可执行权限的accelbox_init.sh脚本用例通过" >> /jffs2/result.txt;
fi'
;;
7)
echo "7.通电初始化--目录包含accelbox文件夹，但不包含ams/agent内容"
sr 'cd /jffs2;sh xy 4'
sleep 60
sr '
rm -r /jffs2/accelbox/ams;
rm -r /jffs2/accelbox/agent;
echo "2.0.17" > /jffs2/accelbox/version;
reboot'
sleep 150
sr '
a=`cat /jffs2/accelbox/version`;
if [ $a = "2.0.8" ];then
echo "7.通电初始化--目录包含accelbox文件夹，但不包含ams/agent内容用例通过" >> /jffs2/result.txt;
fi'
;;
8)
echo "8.通电初始化--目录包含accelbox文件夹,但ams/agent无执行权限"
sr 'cd /jffs2;sh xy 4'
sleep 60
sr '
chmod -x /jffs2/accelbox/ams/ams;
chmod -x /jffs2/accelbox/ams/agent-box;
echo "2.0.17" > /jffs2/accelbox/version;
reboot'
sleep 150
sr '
a=`cat /jffs2/accelbox/version`;
if [ $a = "2.0.8" ];then
echo "8.通电初始化--目录包含accelbox文件夹,但ams/agent无执行权限用例通过" >> /jffs2/result.txt;
fi'
;;
9)
echo "9.通电初始化--目录不包含accelbox，但包含accelbox_bak"
sr 'cd /jffs2;sh xy 4'
sleep 60
sr '
cp -R /jffs2/accelbox /jffs2/accelbox_bak;
rm -r /jffs2/accelbox;
echo "2.0.17" > /jffs2/accelbox_bak/version;
reboot'
sleep 150
sr '
a=`cat /jffs2/accelbox/version`;
if [ $a = "2.0.17" ];then
echo "9.通电初始化--目录不包含accelbox，但包含accelbox_bak用例通过" >> /jffs2/result.txt;
fi'
;;
10)
echo "10.通电初始化--accelbox_bak还原为accelbox发生异常"
sr 'cd /jffs2;sh xy 4'
sleep 60
sr '
cp -R /jffs2/accelbox /jffs2/accelbox_bak;
rm -r /jffs2/accelbox;
rm -r /jffs2/accelbox_bak/ams;
rm -r /jffs2/accelbox_bak/agent;
echo "2.0.17" > /jffs2/accelbox_bak/version;
reboot'
sleep 150
sr '
a=`cat /jffs2/accelbox/version`;
if [ $a = "2.0.8" ];then
echo "10.通电初始化--accelbox_bak还原为accelbox发生异常用例通过" >> /jffs2/result.txt;
fi'
;;
11)
echo "11.通电初始化--校验/opt/gamebox中包含accelbox.tar.gz"
sr 'cd /jffs2;sh xy 4'
sleep 60
sr '
a=`ls /opt/gamebox/accelbox.tar.gz |wc -l`;
if [ $a -ne 0 ];then
echo "11.通电初始化--校验/opt/gamebox中包含accelbox.tar.gz用例通过" >> /jffs2/result.txt;
fi'
;;
12)
echo "12.通电初始化--/jjfs2不包含accelbox/accelbox_bak"
sr 'cd /jffs2;sh xy 4'
sleep 60
sr '
rm -r /jffs2/accelbox;
rm -r /jffs2/accelbox_bak;
reboot'
sleep 150
sr '
a=`cat /jffs2/accelbox/version`;
if [ $a = "2.0.8" ];then
echo "12.通电初始化--/jjfs2不包含accelbox/accelbox_bak用例通过" >> /jffs2/result.txt;
fi'
;;
13)
echo "13.reset键--校验/opt/gamebox/bin/recover脚本存在"
sr 'cd /jffs2;sh xy 4'
sleep 60
sr '
a=`ls /opt/gamebox/bin/recover.sh |wc -l`;
if [ $a -eq 1 ];then
echo "13.reset键--校验/opt/gamebox/bin/recover脚本存在用例通过" >> /jffs2/result.txt;
fi'
;;
14)
echo "14.升级前准备--通电之后检查accel-guard/ams/agent进程"
sr 'cd /jffs2;sh xy 4'
sleep 60
sr '
num=0;
a=`ps |grep accel-guard |grep -Ev grep |wc -l`;
b=`ps |grep ams |grep -Ev grep |wc -l`;
c=`ps |grep agent-box |grep -Ev grep |wc -l`;
if [ $a -eq 1 ];then
let num++;
fi;
if [ $b -eq 1 ];then
let num++;
fi;
if [ $c -eq 1 ];then
let num++;
fi;
if [ $num -eq 3 ];then
echo "14.升级前准备--通电之后检查accel-guard/ams/agent进程都存在用例通过" >> /jffs2/result.txt;
fi'
;;
15)
echo "15.升级前准备--中断ams/agent进程后拉起(accel_guard正常)"
sr 'cd /jffs2;sh xy 4'
sleep 60
sr 'killall ams agent-box'
sleep 10
sr '
num=0
b=`ps |grep ams |grep -Ev grep |wc -l`;
c=`ps |grep agent-box |grep -Ev grep |wc -l`;
if [ $b -eq 1 ];then
let num++;
fi;
if [ $c -eq 1 ];then
let num++;
fi;
if [ $num -eq 2 ];then
echo "15.升级前准备--中断ams/agent进程后拉起(accel_guard正常)用例通过" >> /jffs2/result.txt;
fi'
;;

19)
echo "19.更新--校验update.sh脚本存在"
sr 'cd /jffs2;sh xy 4'
sleep 60
sr '
a=`ls /jffs2/accelbox/script/update.sh |wc -l`;
if [ $a -eq 1 ];then
echo "19.更新--校验update.sh脚本存在用例通过" >> /jffs2/result.txt;
fi'
;;











esac
done
