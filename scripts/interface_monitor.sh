#!/bin/sh

BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="BOT_CHAT_ID"

INTERFACES="em0 em1"

STATE_DIR="/tmp/interface_status"

mkdir -p "$STATE_DIR"

for IFACE in $INTERFACES
do

    if ifconfig "$IFACE" >/dev/null 2>&1; then

        STATUS=$(ifconfig "$IFACE" | grep "status:" | awk '{print $2}')

        [ -z "$STATUS" ] && STATUS="UNKNOWN"

    else

        STATUS="MISSING"

    fi

    STATE_FILE="$STATE_DIR/$IFACE"

    if [ -f "$STATE_FILE" ]; then
        PREVIOUS=$(cat "$STATE_FILE")
    else
        PREVIOUS="UNKNOWN"
    fi

    if [ "$STATUS" != "$PREVIOUS" ]; then

        case "$STATUS" in

            active)
                ICON="🟢"
                TEXT="UP"
                ;;

            no-carrier)
                ICON="🔴"
                TEXT="DOWN"
                ;;

            *)
                ICON="🟡"
                TEXT="$STATUS"
                ;;
        esac

        MESSAGE="$ICON Interface Status Changed

Interface : $IFACE

Status : $TEXT

Time : $(date)"

        curl -s \
        -X POST \
        "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
        -d chat_id="$CHAT_ID" \
        --data-urlencode text="$MESSAGE" >/dev/null

        echo "$STATUS" > "$STATE_FILE"

    fi

done
