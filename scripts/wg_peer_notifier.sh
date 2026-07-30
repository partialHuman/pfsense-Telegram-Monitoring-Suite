#!/bin/sh

BOT_TOKEN="7865668334:AAFozvwC4O9r3s_GpsDVbDcVB6WCs-HXvVY"
CHAT_ID="7402422471"

VPN_STATUS=$(ifconfig | grep -i "tun_wg0" | wc -l)

if [ "$VPN_STATUS" -eq 0 ]; then
    MESSAGE="⚠️ VPN Disconnected!"
else
    MESSAGE="✅ VPN Connected!"
fi

curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
     -d "chat_id=$CHAT_ID" \
     -d "text=$MESSAGE"

WG_INTERFACE="tun_wg0"

# Consider a peer disconnected if no handshake for 90 seconds
TIMEOUT=90

STATE_DIR="/tmp/wg_peers"

mkdir -p "$STATE_DIR"

CURRENT_TIME=$(date +%s)

wg show "$WG_INTERFACE" latest-handshakes | while read PUBKEY HANDSHAKE
do

    STATE_FILE="$STATE_DIR/$PUBKEY"

    if [ "$HANDSHAKE" -gt 0 ] 2>/dev/null &&
       [ $((CURRENT_TIME - HANDSHAKE)) -lt "$TIMEOUT" ]
    then
        CURRENT_STATE="UP"
    else
        CURRENT_STATE="DOWN"
    fi

    if [ -f "$STATE_FILE" ]; then
        PREVIOUS_STATE=$(cat "$STATE_FILE")
    else
        PREVIOUS_STATE="UNKNOWN"
    fi

    if [ "$CURRENT_STATE" != "$PREVIOUS_STATE" ]; then

        if [ "$CURRENT_STATE" = "UP" ]; then
            MESSAGE="?? WireGuard Peer Connected

Public Key:
$PUBKEY

Time:
$(date)"
        else
            MESSAGE="?? WireGuard Peer Disconnected

Public Key:
$PUBKEY

Time:
$(date)"
        fi

        curl -s -X POST \
        "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
        -d chat_id="$CHAT_ID" \
        --data-urlencode "text=$MESSAGE" >/dev/null

        echo "$CURRENT_STATE" > "$STATE_FILE"

    fi

done