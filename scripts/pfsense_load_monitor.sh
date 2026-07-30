#!/bin/sh

# Telegram Bot Credentials
BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="BOT_CHAT_ID"

# Extract memory details
MEM_INFO=$(top -d1 | grep "Mem:")
ACTIVE=$(echo $MEM_INFO | awk '{print $2}' | tr -d M)   # Active memory in MB
INACT=$(echo $MEM_INFO | awk '{print $4}' | tr -d M)    # Inactive memory in MB
WIRED=$(echo $MEM_INFO | awk '{print $6}' | tr -d M)    # Wired memory in MB
FREE=$(echo $MEM_INFO | awk '{print $8}' | tr -d M)     # Free memory in MB

# Calculate total and used memory
MEM_TOTAL=$((ACTIVE + INACT + WIRED + FREE))
MEM_USED=$((ACTIVE + WIRED))
MEM_USAGE=$(echo "scale=2; 100 * $MEM_USED / $MEM_TOTAL" | bc)

# Extract system details
CPU_USAGE=$(top -d1 | grep "CPU:" | awk '{print $2}')
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}')
TEMP=$(sysctl -n dev.cpu.0.temperature)

# 🔥 📊 🖥 💾 🛑 🌡
# Send message to Telegram
MESSAGE="🔥 *pfSense Load Report* 🔥
📊 *Load Average:* $(uptime | awk -F'load averages: ' '{print $2}')
🖥  *CPU Usage:* ${CPU_USAGE}%
💾 *Disk Usage:* ${DISK_USAGE}%
🛑 *Memory Usage:* ${MEM_USAGE}%
🌡 *Temperature:* ${TEMP}"

curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
-d chat_id=$CHAT_ID \
-d text="$MESSAGE" \
-d parse_mode="Markdown"
