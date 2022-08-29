i=0
if [ $# -ne 2 ]
then
echo "please input count sleep_time"
exit 1
fi
count=$1
sleep_time=$2
while [ $i -lt $count ]
do
let i++
rm -rf test_$i.sh
touch test_$i.sh
chmod +x test_$i.sh
echo "
date
echo \"test_$i.sh start\" 
sleep $sleep_time
date
echo \"test_$i.sh end\" " > test_$i.sh
done
