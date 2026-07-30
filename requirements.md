# Requirements

This document lists the software, packages, hardware, and configuration required to deploy the **pfSense Telegram Monitoring Suite**.

---

# System Requirements

| Component | Requirement |
|-----------|-------------|
| Operating System | pfSense CE 2.7+ / pfSense Plus |
| Shell | FreeBSD sh (Default) |
| Cron | pfSense Cron Package |
| Internet | Required |
| Telegram Bot | Required |
| Root Access | Required |

---

# Hardware Requirements

Minimum

| Component | Specification |
|-----------|--------------|
| CPU | Dual Core 1 GHz |
| RAM | 2 GB |
| Storage | 8 GB |
| Network Interfaces | 2 |

Recommended

| Component | Specification |
|-----------|--------------|
| CPU | Quad Core |
| RAM | 4 GB or higher |
| Storage | 20 GB SSD |
| Network Interfaces | 2 or more |

---

# Required pfSense Packages

Install the following packages from

```
System
    └── Package Manager
```

## Required

| Package | Purpose |
|----------|---------|
| Cron | Schedule monitoring scripts |

---

## Optional

| Package | Purpose |
|----------|---------|
| WireGuard | VPN Monitoring |
| Suricata | IDS/IPS Monitoring |
| pfBlockerNG | IP Reputation & DNS Filtering |
| ntopng | Traffic Monitoring |

---

# Required Utilities

The following utilities are available by default in pfSense.

| Utility | Purpose |
|----------|---------|
| curl | Telegram API Requests |
| grep | Log Parsing |
| awk | Text Processing |
| sed | Text Manipulation |
| ifconfig | Interface Status |
| ping | Connectivity Checks |
| netstat | Network Statistics |
| openssl | Certificate Monitoring |
| sha256 | Configuration Integrity |
| logger | System Logging |
| date | Timestamp Generation |

---

# Telegram Requirements

Create a Telegram Bot using **@BotFather**.

Obtain

- Bot Token
- Chat ID

Configure

```
config/telegram.conf
```

Example

```bash
BOT_TOKEN="YOUR_BOT_TOKEN"

CHAT_ID="YOUR_CHAT_ID"
```

---

# Directory Structure

The following directories are required.

```
/root/scripts/

/root/scripts/state/

/root/scripts/logs/

/tmp/
```

---

# File Permissions

Make all scripts executable.

```bash
chmod +x /root/scripts/*.sh
```

---

# Cron Configuration

Install the pfSense Cron package.

Typical schedule

```
Every Minute
```

Example

```
* * * * * /root/scripts/system_monitor.sh

* * * * * /root/scripts/firewall_monitor.sh

* * * * * /root/scripts/vpn_monitor.sh
```

---

# Network Requirements

The firewall must have

- Internet Connectivity
- DNS Resolution
- Access to Telegram API Servers

Required outbound HTTPS

```
https://api.telegram.org
```

---

# Firewall Permissions

Allow outbound HTTPS (TCP 443) to

```
api.telegram.org
```

---

# Supported Monitoring Modules

| Module | Dependency |
|---------|------------|
| System Monitor | None |
| WAN Monitor | None |
| Internet Monitor | None |
| Gateway Monitor | None |
| Interface Monitor | None |
| VPN Monitor | WireGuard |
| VPN Peer Monitor | WireGuard |
| Firewall Monitor | None |
| WebGUI Login Monitor | None |
| SSH Login Monitor | SSH Enabled |
| DHCP Monitor | DHCP Server |
| New Device Monitor | DHCP Server |
| Config Change Monitor | None |
| Config Backup | None |
| Reboot Monitor | None |
| Service Monitor | None |
| Suricata Monitor | Suricata Package |
| Certificate Monitor | OpenSSL |
| Package Monitor | Package Manager |
| Alias Monitor | None |
| Firewall Rule Monitor | None |
| Port Scan Detection | Firewall Logs |
| Daily Report | None |
| Weekly Report | None |

---

# Log Files Used

| Log File | Purpose |
|----------|---------|
| /var/log/system.log | System Events |
| /var/log/filter.log | Firewall Events |
| /var/dhcpd/var/db/dhcpd.leases | DHCP Monitoring |
| /cf/conf/config.xml | Configuration Monitoring |
| /var/log/suricata/*/alerts.log | IDS Alerts |

---

# State Files

The monitoring scripts store temporary state information to prevent duplicate alerts.

Example

```
/tmp/wg_status

/tmp/interface_status/

/tmp/config_hash

/tmp/webgui_offset

/tmp/filter_offset

/tmp/service_status

/tmp/known_devices

/tmp/reboot_state
```

These files are automatically created during the first execution.

---

# Supported Notification Types

- Telegram Messages
- Markdown Formatting
- Emoji Support
- Instant Alerts
- Daily Reports
- Weekly Reports

---

# Tested Environment

The project has been tested on the following environment.

| Component | Version |
|-----------|---------|
| pfSense CE | 2.7.x |
| FreeBSD | 14.x |
| WireGuard | Latest Package |
| Suricata | Latest Package |
| Cron | Latest Package |
| Telegram Bot API | Current Version |

---

# Recommended Knowledge

Basic understanding of

- pfSense
- FreeBSD Shell
- Cron Jobs
- Firewall Rules
- VPN Concepts
- WireGuard
- Telegram Bots
- Network Security

---

# Estimated Resource Usage

| Resource | Usage |
|-----------|-------|
| CPU | Very Low (<2%) |
| RAM | Very Low (<50 MB) |
| Storage | Minimal |
| Network | HTTPS Requests Only |

---

# Installation Checklist

- [ ] Install pfSense
- [ ] Configure Internet Connectivity
- [ ] Install Cron Package
- [ ] Install WireGuard (Optional)
- [ ] Install Suricata (Optional)
- [ ] Create Telegram Bot
- [ ] Configure `telegram.conf`
- [ ] Copy Scripts to `/root/scripts/`
- [ ] Make Scripts Executable
- [ ] Configure Cron Jobs
- [ ] Test Telegram Notifications
- [ ] Verify All Monitoring Modules

---

# Notes

- WireGuard-related scripts require the WireGuard package.
- Suricata monitoring requires the Suricata package.
- All scripts are independent and can be enabled or disabled individually.
- Temporary state files are stored under `/tmp` and recreated automatically after reboot.
- The project is modular, allowing administrators to deploy only the monitoring components they need.