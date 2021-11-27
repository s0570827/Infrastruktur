#!usr/bin/env bash
/usr/bin/aws dynamodb scan --table-name URL_DB | /usr/bin/jq '.' > /home/ubuntu/urls.json

for n in $(seq $(/usr/bin/jq '.Count' /home/ubuntu/urls.json))
do 
	let n--
	/usr/bin/nmap -oN /home/ubuntu/scan.txt $(/usr/bin/jq -r '.Items['$n'].URL.S' /home/ubuntu/urls.json)
	/usr/bin/jq -n --arg date_now $(date +\%F_\%H-\%M-\%S) --arg scan_url $(/usr/bin/jq -r '.Items['$n'].URL.S' /home/ubuntu/urls.json) --arg scan_result "$(cat scan.txt)" '{"date": $date_now,"URL": $scan_url,"scan": $scan_result}' > /home/ubuntu/scan.json
	rm /home/ubuntu/scan.txt
	/usr/bin/aws sns publish --topic-arn "arn:aws:sns:eu-central-1:938475295723:Scan_Done" --message file:///home/ubuntu/scan.json
	rm /home/ubuntu/scan.json
done

rm /home/ubuntu/urls.json

