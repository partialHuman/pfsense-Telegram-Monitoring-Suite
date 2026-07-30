#!/bin/sh

# Telegram Bot Details
BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="BOT_CHAT_ID"

# Get Interface Information
INTERFACES=$(ifconfig | awk '
/^[a-z]/ { iface=$1 }
/status:/ { status=$2 }
/inet / { ip=$2; print iface " | ✅ UP | " ip }
' | column -t)

# Get Gateway Information
GATEWAYS=$(netstat -rn | awk '
/default/ { print "🌐 " $1 " | " $2 " | ✅ Online (Default)" }
/^10\./ { print "➡️ " $1 " | " $2 " | ✅ Online" }
')

# Construct Message
MESSAGE="📡 *pfSense Network Status*

🖧 *Interfaces*
\`\`\`
Name      | Status | IP Address
-------------------------------
$INTERFACES
\`\`\`

🌐 *Gateways*
\`\`\`
Name      | Gateway IP    | Status
---------------------------------
$GATEWAYS
\`\`\`"

# Send to Telegram
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
     -d "chat_id=$CHAT_ID" \
     -d "text=$MESSAGE" \
     -d "parse_mode=Markdown"
