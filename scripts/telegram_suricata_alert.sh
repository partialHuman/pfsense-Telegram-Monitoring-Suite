#!/bin/sh

BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="BOT_CHAT_ID"

LOG_FILE="/var/log/suricata/suricata_em135124/alerts.log"

tail -F "$LOG_FILE" | while read LINE
do
    echo "$LINE" | grep -Eq "Priority: (1|2)" || continue

    MSG="?? Critical Suricata Alert

$LINE"

    curl -s -X POST \
    "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
    -d chat_id="$CHAT_ID" \
    -d text="$MSG" >/dev/null
done