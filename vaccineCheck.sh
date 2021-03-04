#!/bin/bash

rm *.json 

curl 'https://mzqsa4noec.execute-api.us-east-1.amazonaws.com/prod' \
  -H 'authority: mzqsa4noec.execute-api.us-east-1.amazonaws.com' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.192 Safari/537.36' \
  -H 'accept: */*' \
  -H 'origin: https://www.macovidvaccines.com' \
  -H 'sec-fetch-site: cross-site' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-dest: empty' \
  -H 'referer: https://www.macovidvaccines.com/' \
  -H 'accept-language: en-US,en;q=0.9' \
  --compressed -o data.json
  jq  ".body |fromjson | .results "  data.json  > results.json


for row in $(cat results.json | jq  -r '.[] | select(.hasAvailability==true)  | select(.name |startswith("Walgreens")) | "Available in "+ .name + "," + .city +" "+ .signUpLink  | @base64'); 
do
    message=`echo ${row} | base64 --decode `
    echo "$message" |sendxmpp <address> -t
done

for row in $(cat results.json | jq  -r '.[] | select(.hasAvailability==true)  | select(.name |startswith("CVS")) | "Available in "+ .name + "," + .city +" "+ .signUpLink  | @base64'); 
do
    message=`echo ${row} | base64 --decode `
    echo "$message" |sendxmpp <address>  -t
done

for row in $(cat results.json | jq  -r '.[] | select(.hasAvailability==true)  | select(.name |startswith("Fenway Park")) | "Available in "+ .name + "," + .city +" "+ .signUpLink  | @base64'); 
do
    message=`echo ${row} | base64 --decode `
    echo "$message" |sendxmpp <address>  -t
done