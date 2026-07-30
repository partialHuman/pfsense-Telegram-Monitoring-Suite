#!/bin/sh

BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="BOT_CHAT_ID"

LEASE_FILE="/var/dhcpd/var/db/dhcpd.leases"
STATE_FILE="/tmp/known_devices"

touch "$STATE_FILE"

grep "^lease " "$LEASE_FILE" | awk '{print $2}' | while read IP
do
    MAC=$(awk -v ip="$IP" '
    $1=="lease" && $2==ip {found=1}
    found && $1=="hardware" {print $3; exit}
    ' "$LEASE_FILE" | tr -d ';')

    HOST=$(awk -v ip="$IP" '
    $1=="lease" && $2==ip {found=1}
    found && $1=="client-hostname" {
        gsub("\"","",$2)
        gsub(";","",$2)
        print $2
        exit
    }' "$LEASE_FILE")

    [ -z "$HOST" ] && HOST="Unknown"

    if ! grep -q "$MAC" "$STATE_FILE"; then

        MESSAGE="?? New Device Connected

Hostname : $HOST
IP       : $IP
MAC      : $MAC
Time      : $(date)"

        curl -s -X POST \
        "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
        -d chat_id="$CHAT_ID" \
        --data-urlencode text="$MESSAGE" >/dev/null

        echo "$MAC" >> "$STATE_FILE"
    fi
done