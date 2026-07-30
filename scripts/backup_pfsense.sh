#!/bin/sh

# Set backup directory and filename
BACKUP_DIR="/root/pfsense_backups"
BACKUP_FILE="config-$(date +%F-%H%M).xml"
RCLONE_REMOTE="gdrive:pfsense_backups"

# Telegram Bot Details
BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="BOT_CHAT_ID"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Copy pfSense configuration
cp /cf/conf/config.xml "$BACKUP_DIR/$BACKUP_FILE"

# Upload backup to Google Drive
if rclone copy "$BACKUP_DIR/$BACKUP_FILE" "$RCLONE_REMOTE"; then

    MESSAGE="✅ *pfSense Backup Completed*
📂 *Backup File:* $BACKUP_FILE
🗄️ *Stored in Google Drive*
🕒 *Time:* $(date +"%Y-%m-%d %H:%M:%S")"

else
    MESSAGE="❌ *pfSense Backup Failed*
🚨 Please check your system."
fi

# Send Telegram notification
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
    -d "chat_id=$CHAT_ID" \
    -d "text=$MESSAGE" \
    -d "parse_mode=Markdown"

# Delete local backups older than 7 days
find "$BACKUP_DIR" -type f -name "config-*.xml" -mtime +7 -exec rm {} \;

echo "Backup completed and uploaded to Google Drive."
