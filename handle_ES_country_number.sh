cat $1 |grep key |awk -F ":" '{print$2}' |sed  's/\"//g' |sed 's/\,//g' |sed 's/\" \"//g' |sed 's/^[ \t]*//g'
cat $1 |grep doc_count |awk -F ":" '{print$2}' |sed  's/\"//g' |sed 's/\,//g' |sed 's/\" \"//g' |sed 's/^[ \t]*//g'
