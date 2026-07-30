#!/bin/sh

BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="BOT_CHAT_ID"

SERVICE="unbound"
STATE_FILE="/tmp/unbound_status"

if pgrep -x "$SERVICE" >/dev/null
then
    CURRENT="RUNNING"
else
    CURRENT="STOPPED"
fi


if [ -f "$STATE_FILE" ]; then
    PREVIOUS=$(cat "$STATE_FILE")
else
    PREVIOUS="UNKNOWN"
fi

if [ "$CURRENT" != "$PREVIOUS" ]; then

    if [ "$CURRENT" = "RUNNING" ]; then

        MESSAGE="🟢 DNS Resolver Started

Service : Unbound
Status  : Running

Time : $(date)"

    else

        MESSAGE="🔴 DNS Resolver Stopped

Service : Unbound
Status  : Stopped

Time : $(date)"

    fi

    curl -s \
    -X POST \
    "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
    -d chat_id="$CHAT_ID" \
    --data-urlencode text="$MESSAGE" >/dev/null

    echo "$CURRENT" > "$STATE_FILE"

fi
