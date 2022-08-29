awk -F ":" '{print$2}' $1 |sed 's/,//g' |awk 'NR==1 {tmp=$1} NR>1 {print ($1-tmp)/100;tmp=$1}'
