#!/bin/sh

BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="BOT_CHAT_ID"

TARGET="8.8.8.8"

MAX_LATENCY=100      # ms
MAX_PACKETLOSS=20    # %

STATE_FILE="/tmp/gateway_health"

OUTPUT=$(ping -c 5 "$TARGET" 2>/dev/null)

LOSS=$(echo "$OUTPUT" | awk -F',' '/packet loss/ {gsub("%","",$3); gsub(" ","",$3); print $3}')

LATENCY=$(echo "$OUTPUT" | awk -F'/' '/round-trip/ {print int($5)}')

[ -z "$LOSS" ] && LOSS=100
[ -z "$LATENCY" ] && LATENCY=9999

STATUS="NORMAL"

if [ "$LOSS" -ge "$MAX_PACKETLOSS" ]; then
    STATUS="PACKETLOSS"
elif [ "$LATENCY" -ge "$MAX_LATENCY" ]; then
    STATUS="HIGH_LATENCY"
fi

if [ -f "$STATE_FILE" ]; then
    PREVIOUS=$(cat "$STATE_FILE")
else
    PREVIOUS="UNKNOWN"
fi

if [ "$STATUS" != "$PREVIOUS" ]; then

    case "$STATUS" in

        NORMAL)
            MESSAGE="🟢 Gateway Healthy

Latency : ${LATENCY} ms
Packet Loss : ${LOSS}%

Time : $(date)"
        ;;

        HIGH_LATENCY)
            MESSAGE="🟡 High Internet Latency

Latency : ${LATENCY} ms
Packet Loss : ${LOSS}%

Threshold : ${MAX_LATENCY} ms

Time : $(date)"
        ;;

        PACKETLOSS)
            MESSAGE="🔴 High Packet Loss

Packet Loss : ${LOSS}%
Latency : ${LATENCY} ms

Threshold : ${MAX_PACKETLOSS}%

Time : $(date)"
        ;;

    esac

    curl -s \
    -X POST \
    "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
    -d chat_id="$CHAT_ID" \
    --data-urlencode text="$MESSAGE" >/dev/null

    echo "$STATUS" > "$STATE_FILE"

fi
