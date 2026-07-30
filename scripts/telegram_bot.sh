#!/bin/sh

BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="BOT_CHAT_ID"

API_URL="https://api.telegram.org/bot$BOT_TOKEN"

# Wait for system to settle after boot
sleep 3

# Send bootup complete message
curl -s -X POST "$API_URL/sendMessage" -d "chat_id=$CHAT_ID" -d "text=🚀 pfSense Bootup Complete!"

# Wait to avoid duplicate messages
sleep 1  

# Get WAN interfaces
MESSAGE="🌐 WAN Connection Status:"
WAN_INTERFACES=$(ifconfig -l | grep -oE 'wan[0-9]*')

if [ -z "$WAN_INTERFACES" ]; then
    MESSAGE="$MESSAGE\n⚠️ No WAN interfaces found!"
else
    for WAN in $WAN_INTERFACES; do
        # Check if interface is UP
        if ifconfig "$WAN" | grep -q "status: active"; then
            WAN_STATUS="✅ UP"
            WAN_IP=$(ifconfig "$WAN" | awk '/inet / {print $2}')
        else
            WAN_STATUS="❌ DOWN"
            WAN_IP="N/A"
        fi
        MESSAGE="$MESSAGE\n$WAN: $WAN_STATUS\n🆔 WAN IP: $WAN_IP"
    done
fi

# Send WAN status message
curl -s -X POST "$API_URL/sendMessage" -d "chat_id=$CHAT_ID" -d "text=$MESSAGE"

