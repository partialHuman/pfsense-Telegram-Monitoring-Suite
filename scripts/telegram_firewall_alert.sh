#!/bin/sh

# Telegram Bot Credentials
BBOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="BOT_CHAT_ID"

tail -F /var/log/filter.log | while read LINE
do
    echo "$LINE" | grep -qi "block"

    if [ $? -eq 0 ]; then

        MESSAGE="?? Firewall Alert

Blocked Connection

$LINE"

        curl -s -X POST \
        "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
        -d chat_id="${CHAT_ID}" \
        -d text="${MESSAGE}"
    fi
done