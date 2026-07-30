#!/bin/sh

BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="BOT_CHAT_ID"

LOG_FILE="/var/log/system.log"
STATE_FILE="/tmp/webgui_log_offset"

if [ ! -f "$STATE_FILE" ]; then
    wc -l < "$LOG_FILE" > "$STATE_FILE"
    exit 0
fi

LAST_LINE=$(cat "$STATE_FILE")
TOTAL_LINES=$(wc -l < "$LOG_FILE")

tail -n +"$((LAST_LINE+1))" "$LOG_FILE" | while read LINE
do

    if echo "$LINE" | grep -qi "webConfigurator login for user"; then

        USER=$(echo "$LINE" | sed -n 's/.*login for user '\''\([^'\'']*\)'\''.*/\1/p')

        IP=$(echo "$LINE" | sed -n 's/.*from \([0-9.]*\).*/\1/p')

        MESSAGE="🟢 pfSense Login Successful

User : $USER
IP   : $IP

Time : $(date)"

        curl -s \
        -X POST \
        "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
        -d chat_id="$CHAT_ID" \
        --data-urlencode text="$MESSAGE" >/dev/null

    fi

    if echo "$LINE" | grep -qi "webConfigurator authentication error"; then

        USER=$(echo "$LINE" | sed -n 's/.*user '\''\([^'\'']*\)'\''.*/\1/p')

        IP=$(echo "$LINE" | sed -n 's/.*from \([0-9.]*\).*/\1/p')

        MESSAGE="🔴 pfSense Login Failed

User : $USER
IP   : $IP

Time : $(date)"

        curl -s \
        -X POST \
        "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
        -d chat_id="$CHAT_ID" \
        --data-urlencode text="$MESSAGE" >/dev/null

    fi

done


echo "$TOTAL_LINES" > "$STATE_FILE"
