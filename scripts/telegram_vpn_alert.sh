#!/bin/sh

BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="BOT_CHAT_ID"


STATE_FILE="/tmp/wg_status"

# Check if WireGuard interface exists
VPN_STATUS=$(ifconfig | grep -i "tun_wg0" | wc -l)

if [ "$VPN_STATUS" -eq 0 ]; then
    CURRENT_STATE="DOWN"
    MESSAGE="⚠️ VPN Disconnected!"
else
    CURRENT_STATE="UP"
    MESSAGE="✅ VPN Connected!"
fi

# Read previous state
if [ -f "$STATE_FILE" ]; then
    PREVIOUS_STATE=$(cat "$STATE_FILE")
else
    PREVIOUS_STATE="UNKNOWN"
fi

# Only notify if state changed
if [ "$CURRENT_STATE" != "$PREVIOUS_STATE" ]; then

    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
        -d "chat_id=$CHAT_ID" \
        --data-urlencode "text=$MESSAGE"

    echo "$CURRENT_STATE" > "$STATE_FILE"
fi
