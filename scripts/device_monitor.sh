#!/bin/sh

# Telegram Bot Details
BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="BOT_CHAT_ID"

# File to store previously known devices
KNOWN_DEVICES="/tmp/known_devices.txt"
NEW_DEVICES="/tmp/new_devices.txt"

# Get the current list of connected devices (IP & MAC)
arp -a | awk '{print $2, $4}' | sed 's/[()]//g' | sort > "$NEW_DEVICES"

# Check for new connections
NEW_CONN=$(comm -13 "$KNOWN_DEVICES" "$NEW_DEVICES")
if [ ! -z "$NEW_CONN" ]; then
    MESSAGE="🟢 *New Device Connected:*\n\`\`\`\n$NEW_CONN\n\`\`\`"
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
        -d "chat_id=$CHAT_ID" \
        -d "text=$MESSAGE" \
        -d "parse_mode=Markdown"
fi

# Check for disconnections
DISCONN=$(comm -23 "$KNOWN_DEVICES" "$NEW_DEVICES")
if [ ! -z "$DISCONN" ]; then
    MESSAGE="🔴 *Device Disconnected:*\n\`\`\`\n$DISCONN\n\`\`\`"
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
        -d "chat_id=$CHAT_ID" \
        -d "text=$MESSAGE" \
        -d "parse_mode=Markdown"
fi

# Update the known devices file
mv "$NEW_DEVICES" "$KNOWN_DEVICES"
