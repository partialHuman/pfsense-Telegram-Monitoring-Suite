#!/bin/sh

# Telegram Bot Details
BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="BOT_CHAT_ID"

# Get Connected Devices with IP and MAC
DEVICES=$(arp -a | awk '{print $1 " | " $2 " | " $4}' | column -t)

# Get DHCP Lease Time (if using DHCP)
LEASES=$(cat /var/dhcpd/var/db/dhcpd.leases | awk '/lease/ {ip=$2} /binding state active/ {getline; print ip, $3, $4}' | column -t)

# Merge ARP and DHCP data
MERGED_DATA=$(echo -e "$DEVICES\n$LEASES" | sort -u)

# Construct Message
MESSAGE="🔍 *Connected Devices*

\`\`\`
Hostname         | IP Address      | MAC Address        | Connected Since
--------------------------------------------------------------
$MERGED_DATA
\`\`\`"

# Send to Telegram
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
     -d "chat_id=$CHAT_ID" \
     -d "text=$MESSAGE" \
     -d "parse_mode=Markdown"
