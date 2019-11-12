#!/usr/bin/env sh

# define an alias named ll for the command ls -al
alias ll='ls -al'

# write a function to curl https://api.iextrading.com/1.0/tops?symbols=AAPL and output the current AAPL stockprice
function curl_apple () {
    # Use bash command to validate that a system command exists.
    URL="https://api.iextrading.com/1.0/tops?symbols=AAPL"
    curl -k "${URL}"
}

function command_exists () {
    # Use bash command to validate that a system command exists.
    arg1="${1:-}"
    type "${arg1}" &> /dev/null ;
}

# When I wrote this the URL for the assignment did not work.
function curl_apple_old(){

    API_URI="sandbox.iexapis.com"
    TOKEN="Tsk_b56a0650dd8f4d73b20991538f4de757"

    API_VERSION="stable"

    SYMBOLS="AAPL"

    URL="https://${API_URI}/${API_VERSION}/tops/last?symbols=${SYMBOLS}&token=${TOKEN}"
    curl -k "${URL}";
}

OUTPUT=$(curl_apple);
# Check if jquery is installed.
if (command_exists "jq"); then
    # This uses jquery which is a popular way to parse JSON. jquery must be installed.
    SYMBOL=$(echo "${OUTPUT}" | jq '.[0].symbol')
    PRICE=$(echo  "${OUTPUT}"  | jq '.[0].lastSalePrice')
else
    # When jquery is not installed we do this.
    SYMBOL=$( echo "${OUTPUT}" | awk 'BEGIN { FS="," } /1/ { print $1 }' |  awk 'BEGIN { FS=":" } { print $2 }')
    PRICE=$(  echo "${OUTPUT}" | awk 'BEGIN { FS="," } /1/ { print $9 }' |  awk 'BEGIN { FS=":" } /1/ { print $2 }')
fi
echo "${SYMBOL} price is ${PRICE}"


# source an additional bash script, ~/.bashrc_extras, if that file exists
FILE=~/.bashrc_extras && test -f $FILE && source $FILE