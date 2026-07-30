#!/bin/sh

BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="BOT_CHAT_ID"

CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=80
LOAD_THRESHOLD=3


# Memory usage calculation
Memory=$(top -d1 | grep Mem)
ACTIVE=$(top -d1 | grep Mem | awk '{print $2}' | tr -d 'M')
INACT=$(top -d1 | grep Mem | awk '{print $4}' | tr -d 'M')
#LAUNDRY=$(top -d1 | grep Mem | awk '{print $6}' | tr -d 'MK')
WIRED=$(top -d1 | grep Mem | awk '{print $6}' | tr -d 'M')
FREE=$(top -d1 | grep Mem | awk '{print $8}' | tr -d 'M')

#echo "ACTIVE: $ACTIVE"
#echo "INACT: $INACT"
#echo "LAUNDRY: $LAUNDRY"
#echo "WIRED: $WIRED"
#echo "FREE: $FREE"
echo "Memory: $Memory"

# Ensure all variables have numeric values (default to zero if empty)
ACTIVE=${ACTIVE:-0}
INACT=${INACT:-0}
LAUNDRY=${LAUNDRY:-0}
WIRED=${WIRED:-0}
FREE=${FREE:-0}

# Calculate total and used memory
TOTAL_MEM=$(($ACTIVE + $INACT + $WIRED + $FREE))
USED_MEM=$(($ACTIVE + $WIRED))
MEM_USAGE=$(( $USED_MEM * 100 / $TOTAL_MEM ))

# Extract system details
CPU_USAGE=$(top -d1 | grep "CPU:" | awk '{print $2}' | tr -d '%')
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
LOAD_AVG=$(uptime | awk -F'load averages: ' '{print $2}' | awk '{print $1}')

# Debugging - Print values
echo "Load avg: $LOAD_AVG"
echo "Cpu Usage: $CPU_USAGE%"
echo "Memory Usage: $MEM_USAGE%"
echo "Disk Usage: $DISK_USAGE%"


# Ensure values are set to zero if empty
CPU_USAGE=${CPU_USAGE:-0}
MEM_USAGE=${MEM_USAGE:-0}
DISK_USAGE=${DISK_USAGE:-0}
LOAD_AVG=${LOAD_AVG:-0}

CPU_ALERT=$(awk -v usage="$CPU_USAGE" -v threshold="$CPU_THRESHOLD" 'BEGIN {print (usage > threshold) ? 1 : 0}')
MEM_ALERT=$(awk -v usage="$MEM_USAGE" -v threshold="$MEM_THRESHOLD" 'BEGIN {print (usage > threshold) ? 1 : 0}')
DISK_ALERT=$(awk -v usage="$DISK_USAGE" -v threshold="$DISK_THRESHOLD" 'BEGIN {print (usage > threshold) ? 1 : 0}')
LOAD_ALERT=$(awk -v usage="$LOAD_AVG" -v threshold="$LOAD_THRESHOLD" 'BEGIN {print (usage > threshold) ? 1 : 0}')

# Send alert only if conditions are met
if [ "$CPU_ALERT" -eq 1 ] || [ "$MEM_ALERT" -eq 1 ] || [ "$DISK_ALERT" -eq 1 ] || [ "$LOAD_ALERT" -eq 1 ]; then

# Improved Temperature Detection
TEMP_OID=$(sysctl -a 2>/dev/null | grep -E "temperature|thermal" | awk -F'[: ]+' '{print $1}' | head -n 1)
if [ -n "$TEMP_OID" ]; then
    TEMP=$(sysctl -n "$TEMP_OID" 2>/dev/null | awk '{print $1}')
else
    TEMP="N/A"
fi
MESSAGE="🔥 *pfSense Load Report* 🔥 
📊 *Load Average:* $LOAD_AVG
💻 *CPU Usage:* ${CPU_USAGE}%
💾 *Disk Usage:* ${DISK_USAGE}%
🧠 *Memory Usage:* ${MEM_USAGE}%
🌡️ *Temperature:* ${TEMP}"

    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
    -d chat_id=$CHAT_ID \
    -d text="$MESSAGE" \
    -d parse_mode="Markdown"
fi
