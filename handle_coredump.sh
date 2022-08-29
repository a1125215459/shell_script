rm handle_coredump.txt
awk -F '-' '{print$4}' $1 >> handle_coredump.txt 
cat handle_coredump.txt |while read line;do date -d @$line|awk '{print$1" "$2" "$3" "$4}';done
