#!/bin/sh

BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="BOT_CHAT_ID"

STATE_FILE="/tmp/boot_time"

BOOT_TIME=$(sysctl -n kern.boottime | sed -E 's/.*sec = ([0-9]+).*/\1/')

if [ ! -f "$STATE_FILE" ]; then
    echo "$BOOT_TIME" > "$STATE_FILE"
    exit 0
fi

PREVIOUS=$(cat "$STATE_FILE")

if [ "$BOOT_TIME" != "$PREVIOUS" ]; then

UPTIME=$(uptime)

MESSAGE="🔄 pfSense Reboot Detected

Hostname : $(hostname)

Boot Time:
$(date -r "$BOOT_TIME")

Current Uptime:
$UPTIME

Time Detected:
$(date)"

curl -s \
-X POST \
"https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
-d chat_id="$CHAT_ID" \
--data-urlencode text="$MESSAGE" >/dev/null

echo "$BOOT_TIME" > "$STATE_FILE"

fi
