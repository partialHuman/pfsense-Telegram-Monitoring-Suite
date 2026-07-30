#!/bin/sh

BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="BOT_CHAT_ID"

CURRENT_IP=$(fetch -qo - https://api.ipify.org)
LAST_IP_FILE="/tmp/last_wan_ip"

if [ ! -f "$LAST_IP_FILE" ]; then
    echo "$CURRENT_IP" > "$LAST_IP_FILE"
    exit 0
fi

LAST_IP=$(cat "$LAST_IP_FILE")

if [ "$CURRENT_IP" != "$LAST_IP" ]; then

MESSAGE="?? pfSense WAN IP Changed

Old IP:
$LAST_IP

New IP:
$CURRENT_IP

Time:
$(date)"

curl -s -X POST \
https://api.telegram.org/bot${BOT_TOKEN}/sendMessage \
-d chat_id="${CHAT_ID}" \
-d text="${MESSAGE}"

echo "$CURRENT_IP" > "$LAST_IP_FILE"

fi