# ⚙️ Configuration Guide

This guide explains how to configure the **pfSense Telegram Monitoring Suite** after installation.

All configuration files are located in the `config/` directory.

```
config/
│
├── telegram.conf
├── monitoring.conf
├── thresholds.conf
├── services.conf
├── notification.conf
├── aliases.conf
├── whitelist.conf
└── cron_jobs.txt
```

---

# Configuration Overview

| File | Purpose |
|------|---------|
| telegram.conf | Telegram Bot configuration |
| monitoring.conf | Enable or disable monitoring modules |
| thresholds.conf | Alert threshold values |
| services.conf | Services to monitor |
| notification.conf | Enable or disable notification categories |
| aliases.conf | Friendly names for VPN peers |
| whitelist.conf | Trusted IP addresses |
| cron_jobs.txt | Example Cron schedule |

---

# 1. Telegram Configuration

File

```
config/telegram.conf
```

Example

```bash
###############################################################################
# Telegram Configuration
###############################################################################

BOT_TOKEN="YOUR_BOT_TOKEN"

CHAT_ID="YOUR_CHAT_ID"

API_URL="https://api.telegram.org"

PARSE_MODE="Markdown"
```

## Parameters

| Variable | Description |
|----------|-------------|
| BOT_TOKEN | Telegram Bot Token obtained from BotFather |
| CHAT_ID | Telegram User or Group Chat ID |
| API_URL | Telegram API endpoint |
| PARSE_MODE | Message formatting (Markdown or HTML) |

---

# 2. Monitoring Configuration

File

```
config/monitoring.conf
```

Example

```bash
ENABLE_SYSTEM_MONITOR=true

ENABLE_FIREWALL_MONITOR=true

ENABLE_SURICATA_MONITOR=true

ENABLE_VPN_MONITOR=true

ENABLE_SERVICE_MONITOR=true

ENABLE_WEBGUI_MONITOR=true

ENABLE_SSH_MONITOR=true

ENABLE_DHCP_MONITOR=true

ENABLE_REPORTS=true
```

## Available Modules

| Module | Description |
|---------|-------------|
| ENABLE_SYSTEM_MONITOR | CPU, RAM, Disk Monitoring |
| ENABLE_FIREWALL_MONITOR | Firewall Log Monitoring |
| ENABLE_SURICATA_MONITOR | IDS Alert Monitoring |
| ENABLE_VPN_MONITOR | WireGuard Monitoring |
| ENABLE_SERVICE_MONITOR | Service Status Monitoring |
| ENABLE_WEBGUI_MONITOR | WebGUI Login Monitoring |
| ENABLE_SSH_MONITOR | SSH Login Monitoring |
| ENABLE_DHCP_MONITOR | DHCP Monitoring |
| ENABLE_REPORTS | Daily & Weekly Reports |

---

# 3. Threshold Configuration

File

```
config/thresholds.conf
```

Example

```bash
CPU_THRESHOLD=90

RAM_THRESHOLD=90

DISK_THRESHOLD=90

LATENCY_THRESHOLD=100

PACKETLOSS_THRESHOLD=20

BANDWIDTH_THRESHOLD=100

CERT_EXPIRY_DAYS=30

VPN_TIMEOUT=180
```

## Parameters

| Parameter | Description |
|-----------|-------------|
| CPU_THRESHOLD | CPU usage alert (%) |
| RAM_THRESHOLD | Memory usage alert (%) |
| DISK_THRESHOLD | Disk usage alert (%) |
| LATENCY_THRESHOLD | Gateway latency (ms) |
| PACKETLOSS_THRESHOLD | Packet loss (%) |
| BANDWIDTH_THRESHOLD | Bandwidth alert (Mbps) |
| CERT_EXPIRY_DAYS | Certificate expiry warning |
| VPN_TIMEOUT | VPN handshake timeout (seconds) |

---

# 4. Services Configuration

File

```
config/services.conf
```

Example

```bash
SERVICES="

unbound

dhcpd

sshd

suricata

wireguard

ntpd

"
```

These services are checked periodically.

If any service stops, a Telegram notification is sent.

---

# 5. Notification Configuration

File

```
config/notification.conf
```

Example

```bash
SYSTEM_ALERTS=true

VPN_ALERTS=true

SURICATA_ALERTS=true

LOGIN_ALERTS=true

DHCP_ALERTS=true

CONFIG_ALERTS=true

PACKAGE_ALERTS=true

CERTIFICATE_ALERTS=true

REPORTS=true
```

Disable a category by changing

```bash
true
```

to

```bash
false
```

---

# 6. VPN Peer Aliases

File

```
config/aliases.conf
```

Example

```bash
Laptop="ABCD123456789"

Office-PC="XYZ987654321"

Phone="MNOP123456789"
```

Instead of receiving

```
Peer ABCD123456789 Connected
```

you receive

```
Laptop Connected
```

---

# 7. Whitelist

File

```
config/whitelist.conf
```

Example

```
127.0.0.1

192.168.1.10

192.168.1.20

10.10.10.2
```

These IP addresses are ignored by modules such as:

- Port Scan Detection
- Failed Login Detection
- Firewall Alerts

---

# 8. Cron Jobs

Example schedule

```
* * * * * system_monitor.sh

* * * * * firewall_monitor.sh

* * * * * vpn_monitor.sh

*/5 * * * * interface_monitor.sh

0 * * * * daily_report.sh

0 0 * * 0 weekly_report.sh
```

You can customize the execution frequency based on your environment.

---

# Configuration Tips

- Keep your Telegram Bot Token private.
- Review threshold values to match your hardware and network.
- Disable modules you do not use.
- Keep the whitelist updated with trusted devices.
- Test configuration changes by running the affected script manually.

---

# Security Recommendations

Never commit the following files to Git:

- `telegram.conf`
- VPN private keys
- Certificates
- `config.xml`
- Backup files

Use the provided `.example` files instead.

---

# Testing Your Configuration

After making changes, test a monitoring script.

```bash
/root/scripts/system_monitor.sh
```

Expected result

```
✅ Telegram notification received successfully.
```

Repeat for other modules to ensure all configurations are working correctly.

---

# Related Documentation

- [Installation Guide](Installation.md)
- [Quick Start Guide](Quick_Start.md)
- [Telegram Setup](Telegram_Setup.md)
- [WireGuard Setup](WireGuard_Setup.md)
- [Monitoring Modules](Monitoring_Modules.md)

---

# Need Help?

If you experience issues after modifying configuration files:

1. Verify file permissions.
2. Check for syntax errors.
3. Ensure required packages are installed.
4. Review the `Troubleshooting.md` guide.
5. Open a GitHub Issue if the problem persists.