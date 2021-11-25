#!usr/bin/env bash
aws dynamodb scan --table-name URL_DB | jq '.' > /home/ubuntu/urls.json

for n in $(seq $(jq '.Count' /home/ubuntu/urls.json))
do 
	let n--
	nmap -oN /home/ubuntu/scan.txt $(jq -r '.Items['$n'].URL.S' /home/ubuntu/urls.json)
	jq -n --arg date_now $(date +%F_%H-%M-%S) --arg scan_url $(jq -r '.Items['$n'].URL.S' /home/ubuntu/urls.json) --arg scan_result "$(cat scan.txt)" '{"date": $date_now,"URL": $scan_url,"scan": $scan_result}' > /home/ubuntu/scan.json
	rm /home/ubuntu/scan.txt
	aws sns publish --topic-arn "arn:aws:sns:eu-central-1:938475295723:Scan_Done" --message file:///home/ubuntu/scan.json
	rm /home/ubuntu/scan.json
done

rm /home/ubuntu/urls.json

