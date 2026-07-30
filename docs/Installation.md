# Installation Guide

This guide explains how to install and configure the **pfSense Telegram Monitoring Suite** on a pfSense firewall.

By the end of this guide, your firewall will be able to send real-time Telegram notifications for system events, VPN status, firewall logs, IDS alerts, and other monitoring modules.

---

# Prerequisites

Before you begin, ensure you have the following:

| Requirement | Status |
|------------|--------|
| pfSense CE 2.7+ or pfSense Plus | Required |
| Administrator Access | Required |
| Internet Connection | Required |
| Telegram Account | Required |
| Telegram Bot | Required |
| Cron Package | Required |

---

# Step 1 – Install Required Packages

Log in to the pfSense WebGUI.

Navigate to

```
System
    └── Package Manager
```

Install the following packages.

## Required

- Cron

## Optional

- WireGuard
- Suricata
- pfBlockerNG
- ntopng

---

# Step 2 – Clone the Repository

SSH into your pfSense firewall.

Navigate to the root directory.

```bash
cd /root
```

Clone the repository.

```bash
git clone https://github.com/YOUR_USERNAME/pfSense-Telegram-Monitoring.git
```

The project directory will be created.

```
/root/pfSense-Telegram-Monitoring
```

---

# Step 3 – Copy the Scripts

Create a scripts directory.

```bash
mkdir -p /root/scripts
```

Copy the monitoring scripts.

```bash
cp scripts/*.sh /root/scripts/
```

---

# Step 4 – Copy Configuration Files

Copy the example configuration files.

```bash
cp config/telegram.conf.example config/telegram.conf

cp config/monitoring.conf.example config/monitoring.conf

cp config/thresholds.conf.example config/thresholds.conf
```

---

# Step 5 – Configure Telegram

Open the Telegram configuration.

```bash
vi config/telegram.conf
```

Example

```bash
BOT_TOKEN="YOUR_BOT_TOKEN"

CHAT_ID="YOUR_CHAT_ID"

API_URL="https://api.telegram.org"

PARSE_MODE="Markdown"
```

Save the file.

---

# Step 6 – Make Scripts Executable

```bash
chmod +x /root/scripts/*.sh
```

---

# Step 7 – Verify Configuration

Check that all required files exist.

```
config/

scripts/

lib/
```

Verify permissions.

```bash
ls -l /root/scripts
```

---

# Step 8 – Install Cron Jobs

Navigate to

```
Services

    └── Cron
```

Add the required jobs.

Example

```
Every Minute

system_monitor.sh

vpn_monitor.sh

firewall_monitor.sh

suricata_monitor.sh
```

Example command

```
/root/scripts/system_monitor.sh
```

Repeat for other scripts.

---

# Step 9 – Test Telegram

Run

```bash
/root/scripts/system_monitor.sh
```

If configured correctly you should receive a Telegram notification.

Example

```
✅ System Monitor Started

Hostname : pfSense

Time : 12:05 PM
```

---

# Step 10 – Verify Individual Modules

Test each monitoring module individually.

Example

```bash
/root/scripts/vpn_monitor.sh

/root/scripts/firewall_monitor.sh

/root/scripts/suricata_monitor.sh

/root/scripts/interface_monitor.sh
```

Verify that Telegram messages are received.

---

# Directory Structure

Your installation should look similar to this.

```
/root/

├── scripts/
│   ├── system_monitor.sh
│   ├── vpn_monitor.sh
│   ├── firewall_monitor.sh
│   ├── ...
│
├── config/
│   ├── telegram.conf
│   ├── monitoring.conf
│   ├── thresholds.conf
│
├── lib/
│   ├── telegram.sh
│   ├── common.sh
│   ├── state.sh
│   └── ...
│
├── logs/
│
└── state/
```

---

# Verify Installation

Run the following commands.

```bash
which curl

which ping

which grep

which openssl
```

Verify Cron.

```bash
service cron status
```

Verify Telegram connectivity.

```bash
curl https://api.telegram.org
```

---

# Updating the Project

Navigate to the project directory.

```bash
cd /root/pfSense-Telegram-Monitoring
```

Pull the latest changes.

```bash
git pull
```

If new scripts or configuration files are added, copy them to the appropriate directories and restart or reload Cron if necessary.

---

# Uninstalling

Stop all Cron jobs.

Delete the scripts.

```bash
rm -rf /root/scripts
```

Delete configuration files if no longer needed.

```bash
rm -rf config
```

Remove the repository.

```bash
rm -rf /root/pfSense-Telegram-Monitoring
```

---

# Troubleshooting

## No Telegram Notifications

Check:

- Telegram Bot Token
- Chat ID
- Internet Connectivity
- Firewall Rules
- API Access

---

## Scripts Not Running

Verify:

```bash
chmod +x scripts/*.sh
```

Check Cron configuration.

---

## WireGuard Monitoring Not Working

Verify:

- WireGuard package installed
- Tunnel configured
- Interface active
- Peer connected

---

## Suricata Alerts Missing

Verify:

- Suricata package installed
- Interface assigned
- Rules updated
- Alerts enabled

---

# Next Steps

Once installation is complete:

1. Configure monitoring modules.
2. Add Cron schedules.
3. Test each script.
4. Review Telegram notifications.
5. Explore the remaining documentation in the `docs/` directory for advanced configuration and customization.