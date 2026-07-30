#!/bin/sh

BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="BOT_CHAT_ID"

CPU_USAGE=$(sysctl -n vm.loadavg | awk '{print $2}' | cut -d. -f1)

if [ "$CPU_USAGE" -ge 80 ]; then
    MESSAGE="⚠️ High CPU Usage: ${CPU_USAGE}%"
else
    MESSAGE="CPU Usage: ${CPU_USAGE}%"
fi
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
     -d "chat_id=$CHAT_ID" \
     -d "text=$MESSAGE"
