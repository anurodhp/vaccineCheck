#!/bin/sh

# curl 'https://mzqsa4noec.execute-api.us-east-1.amazonaws.com/prod' \
#   -H 'authority: mzqsa4noec.execute-api.us-east-1.amazonaws.com' \
#   -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.192 Safari/537.36' \
#   -H 'accept: */*' \
#   -H 'origin: https://www.macovidvaccines.com' \
#   -H 'sec-fetch-site: cross-site' \
#   -H 'sec-fetch-mode: cors' \
#   -H 'sec-fetch-dest: empty' \
#   -H 'referer: https://www.macovidvaccines.com/' \
#   -H 'accept-language: en-US,en;q=0.9' \
#   --compressed -o data.json
  jq  ".body |fromjson | .results "  data.json  > results.json
  

IFS=$'\n'
for row in $(cat results.json | jq '. | map([.name, .city, .hasAvailability, .signUpLink])'  )
do
  # Run the row through the shell interpreter to remove enclosing double-quotes
  #stripped=$(echo $row | xargs echo)
jq '.hasAvailability' < $row
  # Call our function to process the row
  # eval must be used to interpret the spaces in $stripped as separating arguments
  #eval sendMessage $stripped
done
unset IFS # Return IFS to its original value