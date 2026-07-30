#!/bin/sh

# Telegram Bot Credentials
BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="BOT_CHAT_ID"

# Extract Default Gateway
DEFAULT_GATEWAY=$(netstat -rW | grep 'default' | awk '{print $2}')

# Extract All Gateways with Status using dpinger
GATEWAY_STATUS=$(pfctl -s Interfaces | grep "gw" | awk '{print $1}')

# Build Message
MESSAGE="🌐 *pfSense Gateway Report* 🌐"

# Iterate Through Gateways
for GATEWAY in $GATEWAY_STATUS; do
    IP=$(echo "$GATEWAY" | cut -d'@' -f2)
    STATUS=$(dpinger -S | grep "$IP" | awk '{print $3}')

    if [ "$IP" = "$DEFAULT_GATEWAY" ]; then
        MESSAGE="$MESSAGE✅ *Default Gateway:* $IP - *[ACTIVE]*"
    else
        MESSAGE="$MESSAGE🔄 *Gateway:* $IP - *[$STATUS]*"
    fi
done

# Send Telegram Alert
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
    -d chat_id=$CHAT_ID \
    -d text="$MESSAGE" \
    -d parse_mode="Markdown"
