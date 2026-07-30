#!/bin/sh

BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="BOT_CHAT_ID"

CERT_DIR="/cf/conf"

# Notify when expiry is within this many days
WARNING_DAYS=30

STATE_DIR="/tmp/cert_alerts"
mkdir -p "$STATE_DIR"

find "$CERT_DIR" -name "*.crt" | while read CERT
do
    CERT_NAME=$(basename "$CERT")

    EXPIRY=$(openssl x509 -enddate -noout -in "$CERT" | cut -d= -f2)

    EXPIRY_EPOCH=$(date -j -f "%b %d %T %Y %Z" "$EXPIRY" "+%s" 2>/dev/null)
    NOW=$(date +%s)

    DAYS_LEFT=$(( (EXPIRY_EPOCH - NOW) / 86400 ))

    STATE_FILE="$STATE_DIR/$CERT_NAME"

    if [ "$DAYS_LEFT" -le "$WARNING_DAYS" ]; then

        TODAY=$(date +%F)

        if [ ! -f "$STATE_FILE" ] || [ "$(cat "$STATE_FILE")" != "$TODAY" ]; then

            MESSAGE="⚠️ Certificate Expiry Alert

Certificate:
$CERT_NAME

Expires In:
$DAYS_LEFT day(s)

Expiry Date:
$EXPIRY"

            curl -s \
            -X POST \
            "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
            -d chat_id="$CHAT_ID" \
            --data-urlencode text="$MESSAGE" >/dev/null

            echo "$TODAY" > "$STATE_FILE"
        fi

    fi

done
