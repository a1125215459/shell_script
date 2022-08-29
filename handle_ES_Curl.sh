start=19
end=28
gte_date=15
#gte=2022-08-${start}T07:33:27Z
#lte=2022-08-15T07:33:27Z
country="Singapore"


file1=ES_Result_Tmp_delayAvg.txt
file2=ES_Result_Tmp_delaySD.txt
file3=ES_Result_Tmp_lossRatio.txt


#country range echoQuaility delayAvg
rm -f $file1 $file2 $file3
touch $file1 $file2 $file3
while [ $start -le $end ]
do
echo -e "\n$start:\n"
curl -u "Bzz123":"subao123"  -H 'http.accept_language: zh-CN,zh;q=0.9' -H 'http.accept_encoding: gzip, deflate' -H 'http://61.155.196.215:8801/app/kibana'  -H 'Origin: http://61.155.196.215:8801' -H 'text/plain, */*; q=0.01' -H 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36' -H 'kbn-version: 5.2.2' -H 'access-control-allow-credentials: true' -H 'Content-Type: application/json; charset=UTF-8' -H 'Connection: keep-alive' -X POST  "http://61.155.196.215:8801/api/console/proxy?uri=%2Fcltrpts_v1-2022.08.*%2Fgamingv3%2F_search" -d "{\"size\":0,\"query\":{\"bool\":{\"must\":[{\"term\":{\"msg.link.server-ip-home.country.keyword\":{\"value\":\"$country\"}}},{\"range\":{\"timestamp\":{\"lte\":\"2022-08-${start}T07:33:27Z\",\"gte\":\"2022-08-15T07:33:27Z\"}}},{\"term\":{\"msg.type\":{\"value\":\"12\"}}},{\"term\":{\"msg.link.protocol\":{\"value\":\"17\"}}}],\"must_not\":[{\"terms\":{\"msg.id.config.keyword\":[\"GX102010010133\",\"GX102010010066\"]}},{\"term\":{\"msg.link.echoQuality.lossRatio\":{\"value\":\"10000\"}}}]}},\"sort\":[{\"timestamp\":{\"order\":\"desc\"}}],\"aggs\":{\"percentiles\":{\"percentile_ranks\":{\"field\":\"msg.link.echoQuality.delayAvg\",\"values\":[50,100,150,200,300,400,500]}}}}" >> $file1 
echo -e "\n" >> $file1
let start++
done
#total_number
echo -e "\n$country total_naumber from: $gte_date to $end"
cat $file1 |awk -F "max_score" '{print$1}' |awk -F "total" '{print$3}' |awk -F ":" '{print$2}' |sed 's/,\"//g' |tr -s "\n"


#%
#cat ES_Result_Tmp.txt |awk -F "values\":{" '{print$2}' |sed 's/}//g' |tr "," "\n" |awk -F ":" '{print$2}' $1 |sed 's/,//g' |awk 'NR==1 {tmp=$1;print($1/100)}  NR>1 {print ($1-tmp)/100;tmp=$1}'
echo -e "\n$country range echoQuaility delayAvg from $gte_date to $end"
cat $file1 |awk -F "values\":{" '{print$2}' |sed 's/}//g' |tr "," "\n" |awk -F ":" '{print$2}' $1 |sed 's/,//g' |awk 'NR==1 {tmp=$1;print($1/100)}  NR>1 {if ($1<tmp){print "**********"}} NR>1 {if ($1>tmp){print ($1-tmp)/100}tmp=$1}'



#range echoQuaility dealySD
start=19
while [ $start -le $end ]
do
echo -e "\n$start:\n"
curl -u "Bzz123":"subao123"  -H 'http.accept_language: zh-CN,zh;q=0.9' -H 'http.accept_encoding: gzip, deflate' -H 'http://61.155.196.215:8801/app/kibana'  -H 'Origin: http://61.155.196.215:8801' -H 'text/plain, */*; q=0.01' -H 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36' -H 'kbn-version: 5.2.2' -H 'access-control-allow-credentials: true' -H 'Content-Type: application/json; charset=UTF-8' -H 'Connection: keep-alive' -X POST  "http://61.155.196.215:8801/api/console/proxy?uri=%2Fcltrpts_v1-2022.08.*%2Fgamingv3%2F_search" -d "{\"size\":0,\"query\":{\"bool\":{\"must\":[{\"term\":{\"msg.link.server-ip-home.country.keyword\":{\"value\":\"$country\"}}},{\"range\":{\"timestamp\":{\"lte\":\"2022-08-${start}T07:33:27Z\",\"gte\":\"2022-08-15T07:33:27Z\"}}},{\"term\":{\"msg.type\":{\"value\":\"12\"}}},{\"term\":{\"msg.link.protocol\":{\"value\":\"17\"}}}],\"must_not\":[{\"terms\":{\"msg.id.config.keyword\":[\"GX102010010133\",\"GX102010010066\"]}},{\"term\":{\"msg.link.echoQuality.lossRatio\":{\"value\":\"10000\"}}}]}},\"sort\":[{\"timestamp\":{\"order\":\"desc\"}}],\"aggs\":{\"percentiles\":{\"percentile_ranks\":{\"field\":\"msg.localQuality.netDelay.quality.delaySD\",\"values\":[30,60,100]}}}}" >> $file2
echo -e "\n" >> $file2
let start++
done


echo -e "\n$country total_naumber from: $gte_date to $end"
cat $file2 |awk -F "max_score" '{print$1}' |awk -F "total" '{print$3}' |awk -F ":" '{print$2}' |sed 's/,\"//g' |tr -s "\n"



echo -e "\n$country range echoQuaility delayAvg from $gte_date to $end"
cat $file2 |awk -F "values\":{" '{print$2}' |sed 's/}//g' |tr "," "\n" |awk -F ":" '{print$2}' $1 |sed 's/,//g' |awk 'NR==1 {tmp=$1;print($1/100)}  NR>1 {if ($1<tmp){print "**********"}} NR>1 {if ($1>tmp){print ($1-tmp)/100}tmp=$1}'

#range echoQuaility lossRatio
start=19
while [ $start -le $end ]
do
echo -e "\n$start:\n"
curl -u "Bzz123":"subao123"  -H 'http.accept_language: zh-CN,zh;q=0.9' -H 'http.accept_encoding: gzip, deflate' -H 'http://61.155.196.215:8801/app/kibana'  -H 'Origin: http://61.155.196.215:8801' -H 'text/plain, */*; q=0.01' -H 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36' -H 'kbn-version: 5.2.2' -H 'access-control-allow-credentials: true' -H 'Content-Type: application/json; charset=UTF-8' -H 'Connection: keep-alive' -X POST  "http://61.155.196.215:8801/api/console/proxy?uri=%2Fcltrpts_v1-2022.08.*%2Fgamingv3%2F_search" -d "{\"size\":0,\"query\":{\"bool\":{\"must\":[{\"term\":{\"msg.link.server-ip-home.country.keyword\":{\"value\":\"$country\"}}},{\"range\":{\"timestamp\":{\"lte\":\"2022-08-${start}T07:33:27Z\",\"gte\":\"2022-08-15T07:33:27Z\"}}},{\"term\":{\"msg.type\":{\"value\":\"12\"}}},{\"term\":{\"msg.link.protocol\":{\"value\":\"17\"}}}],\"must_not\":[{\"terms\":{\"msg.id.config.keyword\":[\"GX102010010133\",\"GX102010010066\"]}},{\"term\":{\"msg.link.echoQuality.lossRatio\":{\"value\":\"10000\"}}}]}},\"sort\":[{\"timestamp\":{\"order\":\"desc\"}}],\"aggs\":{\"percentiles\":{\"percentile_ranks\":{\"field\":\"msg.localQuality.netDelay.quality.lossRatio\",\"values\":[100,500,1000]}}}}" >> $file3
echo -e "\n" >> $file3
let start++
done


echo -e "\n$country total_naumber from: $gte_date to $end"
cat $file3 |awk -F "max_score" '{print$1}' |awk -F "total" '{print$3}' |awk -F ":" '{print$2}' |sed 's/,\"//g' |tr -s "\n"


echo -e "\n$country range echoQuaility delayAvg from $gte_date to $end"
cat $file3 |awk -F "values\":{" '{print$2}' |sed 's/}//g' |tr "," "\n" |awk -F ":" '{print$2}' $1 |sed 's/,//g' |awk 'NR==1 {tmp=$1;print($1/100)}  NR>1 {if ($1<tmp){print "**********"}} NR>1 {if ($1>tmp){print ($1-tmp)/100}tmp=$1}'
