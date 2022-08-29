if [ $# -eq 0 ]
then
read -p "input filename" file
else 
file=$1
fi
cat $file |sed 's/[[:space:]]//g' |tr "\n" " "|sed 's/ //g' |sed 's/\"/\\\"/g'
#cat $file |sed 's/^[[:space:]]*//g' |tr -s '\n'
#cat $file |awk '{printf "%s",$1}' |sed 's/ //g'

