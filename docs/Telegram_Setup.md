#  Telegram Bot Setup

This guide explains how to create and configure a Telegram Bot for the **pfSense Telegram Monitoring Suite**.

The monitoring scripts use the **Telegram Bot API** to send real-time notifications whenever important events occur on your pfSense firewall.

---

# Prerequisites

Before starting, ensure you have:

- A Telegram account
- The Telegram mobile or desktop application
- Internet connectivity

---

# Overview

The setup process consists of four simple steps:

1. Create a Telegram Bot
2. Obtain the Bot Token
3. Obtain your Chat ID
4. Configure the project

---

# Step 1 – Create a Telegram Bot

Open Telegram and search for

```
@BotFather
```

Open the verified BotFather account.

Click **Start**.

Run the following command:

```
/newbot
```

BotFather will ask for:

### Bot Name

Example

```
pfSense Monitor
```

### Bot Username

The username must be unique and end with **bot**.

Example

```
pfSenseMonitorBot

FirewallAlertsBot

HomeSOCBot
```

Once created, BotFather returns something similar to:

```
Done!

Use this token to access the HTTP API:

1234567890:AAEabcdefghijklmnopqrstuvwxyz123456789
```

Save this token securely.

---

# Step 2 – Start Your Bot

Search for your newly created bot.

Example

```
@pfSenseMonitorBot
```

Open the chat.

Click

```
Start
```

or send

```
/start
```

This step is required before the bot can send you messages.

---

# Step 3 – Obtain Your Chat ID

There are multiple ways to get your Chat ID.

### Method 1 (Recommended)

Open your browser and replace `<BOT_TOKEN>` with your bot token.

```
https://api.telegram.org/bot<BOT_TOKEN>/getUpdates
```

Example

```
https://api.telegram.org/bot1234567890:AAExxxxxxxxx/getUpdates
```

You should receive JSON output similar to:

```json
{
  "ok": true,
  "result": [
    {
      "message": {
        "chat": {
          "id": 987654321,
          "first_name": "John"
        }
      }
    }
  ]
}
```

Your Chat ID is

```
987654321
```

---

# Step 4 – Configure the Project

Open

```
config/telegram.conf
```

Example

```bash
BOT_TOKEN="1234567890:AAExxxxxxxxxxxxxxxxx"

CHAT_ID="987654321"

API_URL="https://api.telegram.org"

PARSE_MODE="Markdown"
```

Save the file.

---

# Step 5 – Test the Configuration

Run one of the monitoring scripts manually.

Example

```bash
/root/scripts/system_monitor.sh
```

You should receive a Telegram message similar to:

```
✅ System Monitor Started

Hostname : pfSense

Time : 10:35 PM
```

---

# Sending a Test Message

You can also verify the Bot API directly using `curl`.

```bash
curl -X POST \
"https://api.telegram.org/bot<BOT_TOKEN>/sendMessage" \
-d chat_id="<CHAT_ID>" \
-d text="Hello from pfSense!"
```

Expected output:

```json
{
  "ok": true,
  "result": {
    ...
  }
}
```

---

# Using a Telegram Group (Optional)

If multiple administrators should receive alerts:

1. Create a Telegram group.
2. Add your bot to the group.
3. Send at least one message in the group.
4. Retrieve the group Chat ID using `getUpdates`.

Group Chat IDs usually begin with:

```
-100xxxxxxxxxx
```

Update your configuration:

```bash
CHAT_ID="-1001234567890"
```

Now all group members will receive notifications.

---

# Example Notifications

## System Alert

```
🖥 High CPU Usage

CPU Usage : 94%

Time : 22:10
```

---

## VPN Alert

```
🟢 WireGuard Peer Connected

Peer : Laptop

IP : 10.10.10.2
```

---

## Firewall Alert

```
🚨 Firewall Block

Source : 203.xxx.xxx.xxx

Destination : WAN
```

---

## Suricata Alert

```
🚨 ET SCAN Nmap Scan Detected

Source

192.168.1.100
```

---

# Security Recommendations

Keep your Bot Token private.

Never commit:

- Telegram Bot Token
- Chat ID
- Configuration files containing secrets

Only commit:

```
telegram.conf.example
```

Your actual

```
telegram.conf
```

should be ignored by Git.

---

# Troubleshooting

## Bot Doesn't Reply

- Ensure the bot has been started using `/start`.
- Verify the Bot Token.
- Confirm the Chat ID.

---

## No Notifications

Check:

- Internet connectivity
- Firewall allows outbound HTTPS
- Correct Bot Token
- Correct Chat ID
- Script permissions

---

## Invalid Token Error

Generate a new Bot Token using BotFather.

Update:

```
config/telegram.conf
```

---

## Chat ID Not Found

Make sure you have sent at least one message to the bot before calling:

```
getUpdates
```

---

# Telegram API References

Useful Bot API methods:

| Method | Purpose |
|--------|---------|
| getUpdates | Retrieve updates and Chat IDs |
| sendMessage | Send text messages |
| sendPhoto | Send images |
| sendDocument | Send reports or backups |
| sendAnimation | Send GIFs |
| sendLocation | Send coordinates |

---

# Related Documentation

- [Installation Guide](Installation.md)
- [Configuration Guide](Configuration.md)
- [Quick Start Guide](Quick_Start.md)
- [Troubleshooting](Troubleshooting.md)

---

# Next Steps

Once Telegram is configured:

1. Configure WireGuard monitoring.
2. Configure Suricata IDS monitoring.
3. Enable Cron jobs.
4. Test each monitoring module.
5. Enjoy real-time firewall notifications! 🎉