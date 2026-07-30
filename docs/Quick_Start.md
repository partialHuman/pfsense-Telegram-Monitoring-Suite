# 🚀 Quick Start Guide

This guide will help you deploy the **pfSense Telegram Monitoring Suite** in approximately **10 minutes**.

If you need more detailed instructions, refer to the [Installation Guide](Installation.md).

---

# Step 1 – Clone the Repository

SSH into your pfSense firewall.

```bash
cd /root

git clone https://github.com/YOUR_USERNAME/pfSense-Telegram-Monitoring.git
```

---

# Step 2 – Copy the Scripts

```bash
mkdir -p /root/scripts

cp scripts/*.sh /root/scripts/
```

---

# Step 3 – Copy Configuration Files

```bash
cp config/telegram.conf.example config/telegram.conf

cp config/monitoring.conf.example config/monitoring.conf

cp config/thresholds.conf.example config/thresholds.conf
```

---

# Step 4 – Configure Telegram

Edit the Telegram configuration.

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

# Step 5 – Make Scripts Executable

```bash
chmod +x /root/scripts/*.sh
```

---

# Step 6 – Configure Cron

Install the **Cron** package from

```
System
    └── Package Manager
```

Open

```
Services
    └── Cron
```

Add your monitoring jobs.

Example

```
Every Minute

/root/scripts/system_monitor.sh

/root/scripts/vpn_monitor.sh

/root/scripts/firewall_monitor.sh
```

---

# Step 7 – Test the Installation

Run a script manually.

```bash
/root/scripts/system_monitor.sh
```

You should receive a Telegram message similar to

```
✅ System Monitor Started

Hostname : pfSense

Time : 12:15 PM
```

---

# Step 8 – Enable Additional Modules

Depending on your setup, enable the scripts you need.

| Module | Requirement |
|---------|-------------|
| VPN Monitoring | WireGuard |
| IDS Monitoring | Suricata |
| Firewall Monitoring | None |
| DHCP Monitoring | DHCP Server |
| Service Monitoring | None |

---

# Typical Cron Schedule

| Script | Schedule |
|---------|----------|
| system_monitor.sh | Every Minute |
| firewall_monitor.sh | Every Minute |
| vpn_monitor.sh | Every Minute |
| interface_monitor.sh | Every 5 Minutes |
| gateway_health_monitor.sh | Every 5 Minutes |
| config_change_monitor.sh | Every 5 Minutes |
| certificate_monitor.sh | Daily |
| daily_report.sh | Daily |
| weekly_report.sh | Weekly |

---

# Verify Everything

Check that:

- ✅ Telegram Bot Token is correct.
- ✅ Chat ID is correct.
- ✅ Internet access is available.
- ✅ Cron jobs are enabled.
- ✅ Scripts are executable.
- ✅ Required packages are installed.
- ✅ Notifications are received successfully.

---

# Recommended Project Structure

```
pfSense-Telegram-Monitoring/

├── scripts/
├── lib/
├── config/
├── docs/
├── images/
├── logs/
├── reports/
├── state/
├── README.md
├── requirements.md
└── LICENSE
```

---

# What's Next?

Now that the project is running, you can:

- Configure advanced monitoring options in [Configuration.md](Configuration.md)
- Set up Telegram notifications in [Telegram_Setup.md](Telegram_Setup.md)
- Configure WireGuard monitoring in [WireGuard_Setup.md](WireGuard_Setup.md)
- Enable Suricata IDS monitoring in [Suricata_Setup.md](Suricata_Setup.md)
- Explore all available monitoring modules in [Monitoring_Modules.md](Monitoring_Modules.md)

---

# Need Help?

If you run into any issues:

1. Review the [Installation Guide](Installation.md).
2. Check the [Troubleshooting Guide](Troubleshooting.md).
3. Browse the [FAQ](FAQ.md).
4. Open a GitHub Issue if the problem persists.

---
