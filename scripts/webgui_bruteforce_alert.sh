#!/bin/sh

BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="BOT_CHAT_ID"

LOG_FILE="/var/log/system.log"
STATE_FILE="/tmp/webgui_login_offset"

THRESHOLD=5

if [ ! -f "$STATE_FILE" ]; then
    wc -l < "$LOG_FILE" > "$STATE_FILE"
    exit 0
fi

LAST_LINE=$(cat "$STATE_FILE")
TOTAL_LINES=$(wc -l < "$LOG_FILE")

NEW_LOGS=$(tail -n +"$((LAST_LINE+1))" "$LOG_FILE")

FAILURES=$(echo "$NEW_LOGS" | grep -i "webConfigurator authentication error")

COUNT=$(echo "$FAILURES" | grep -c .)

if [ "$COUNT" -ge "$THRESHOLD" ]; then

    IPS=$(echo "$FAILURES" | \
        awk -F'from ' '{print $2}' | \
        awk '{print $1}' | \
        sort | uniq -c)

MESSAGE="🚨 Possible WebGUI Brute Force Attack

Failed Logins : $COUNT

Source IPs:
$IPS

Time:
$(date)"

curl -s \
-X POST \
"https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
-d chat_id="$CHAT_ID" \
--data-urlencode text="$MESSAGE" >/dev/null

fi

echo "$TOTAL_LINES" > "$STATE_FILE"
