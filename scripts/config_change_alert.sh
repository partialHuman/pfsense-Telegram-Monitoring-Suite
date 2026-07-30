#!/bin/sh

BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="BOT_CHAT_ID"

CONFIG_FILE="/cf/conf/config.xml"
HASH_FILE="/tmp/config_hash"

CURRENT_HASH=$(sha256 -q "$CONFIG_FILE")

if [ ! -f "$HASH_FILE" ]; then
    echo "$CURRENT_HASH" > "$HASH_FILE"
    exit 0
fi

PREVIOUS_HASH=$(cat "$HASH_FILE")

if [ "$CURRENT_HASH" != "$PREVIOUS_HASH" ]; then

MESSAGE="⚙️ pfSense Configuration Changed

A modification to config.xml has been detected.

Time:
$(date)

Please verify the changes in the pfSense WebGUI."

curl -s \
-X POST \
"https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
-d chat_id="$CHAT_ID" \
--data-urlencode text="$MESSAGE" >/dev/null

echo "$CURRENT_HASH" > "$HASH_FILE"

fi
