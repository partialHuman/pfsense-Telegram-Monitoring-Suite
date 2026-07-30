#!/bin/sh

BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="BOT_CHAT_ID"

LOG="/var/log/system.log"
STATE="/tmp/login_alert.line"

LAST_LINE=0
[ -f "$STATE" ] && LAST_LINE=$(cat "$STATE")

TOTAL=$(wc -l < "$LOG")

tail -n +"$((LAST_LINE+1))" "$LOG" | \
grep "webConfigurator authentication error" | while read LINE
do

MESSAGE="?? pfSense Login Failure

$LINE"

curl -s -X POST \
"https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
-d chat_id="$CHAT_ID" \
--data-urlencode text="$MESSAGE" >/dev/null

done

echo "$TOTAL" > "$STATE"