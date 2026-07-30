# 🛡️ Suricata Setup Guide

This guide explains how to install, configure, and integrate **Suricata IDS/IPS** with the **pfSense Telegram Monitoring Suite**.

Once completed, your firewall will automatically detect suspicious network activity and send real-time Telegram notifications for critical Suricata alerts.

---

# Overview

Suricata is an open-source Intrusion Detection and Prevention System (IDS/IPS) capable of detecting:

- Network scans
- Brute-force attacks
- Malware communication
- Exploits
- Protocol anomalies
- Suspicious traffic

The monitoring suite continuously monitors Suricata alert logs and immediately forwards important events to Telegram.

---

# Prerequisites

Before starting, ensure you have:

- pfSense CE 2.7+ or pfSense Plus
- Administrator access
- Internet connectivity
- Telegram Bot configured
- Cron package installed

---

# Step 1 – Install Suricata

Navigate to

```
System
    └── Package Manager
```

Search for

```
Suricata
```

Click

```
Install
```

Wait until installation completes.

---

# Step 2 – Open Suricata

Navigate to

```
Services
    └── Suricata
```

---

# Step 3 – Add an Interface

Click

```
Interfaces

↓

Add
```

Select the interface to monitor.

Typical configuration:

| Interface | Recommendation |
|-----------|---------------|
| WAN | Recommended |
| LAN | Optional |
| OPT | Optional |

Most deployments monitor the WAN interface.

---

# Step 4 – Enable the Interface

Enable

```
✓ Enable Suricata
```

Recommended settings:

| Setting | Value |
|----------|------|
| IPS Mode | Disabled (IDS mode) |
| Block Offenders | Optional |
| Promiscuous Mode | Enabled |
| Kill States | Enabled |

Save the configuration.

---

# Step 5 – Configure Rule Sources

Navigate to

```
Updates
```

Enable one or more rule sets.

Common options include:

- Emerging Threats Open
- Snort Community Rules (if available)
- Custom local rules

Download and update the rules.

---

# Step 6 – Configure Logging

Navigate to

```
Logging Settings
```

Enable:

- Alert Logging
- Unified2 or EVE JSON (optional)
- Fast Log (optional)

For this project, alert logging must be enabled.

---

# Step 7 – Verify Alert Log

SSH into pfSense.

Locate the alert log.

Typical location:

```
/var/log/suricata/
```

Example:

```
/var/log/suricata/suricata_em0*/alerts.log
```

Verify the file exists.

```bash
ls /var/log/suricata/
```

---

# Step 8 – Start Suricata

Navigate to

```
Services

↓

Suricata

↓

Start
```

Verify the status.

```
Running
```

---

# Step 9 – Test Detection

Generate simple network activity.

Example

Run an Nmap scan from another machine.

```bash
nmap 192.168.1.1
```

If rules are configured correctly, Suricata should generate alerts.

---

# Step 10 – Enable Monitoring Script

Copy

```
suricata_monitor.sh
```

to

```
/root/scripts/
```

Make executable.

```bash
chmod +x /root/scripts/suricata_monitor.sh
```

Add a Cron job.

Example

```
* * * * * /root/scripts/suricata_monitor.sh
```

---

# Telegram Notifications

Example alert

```
🚨 Suricata Alert

Rule

ET SCAN Nmap Scripting Engine User-Agent Detected

Source

192.168.1.100

Destination

192.168.1.1

Priority

2

Time

22:45
```

---

# Alert Workflow

```
Network Traffic

↓

Suricata Engine

↓

Rule Match

↓

alerts.log

↓

suricata_monitor.sh

↓

Telegram Bot API

↓

Telegram Notification
```

---

# Configuration

Enable IDS monitoring.

```
config/monitoring.conf
```

Example

```bash
ENABLE_SURICATA_MONITOR=true
```

Enable notifications.

```
config/notification.conf
```

Example

```bash
SURICATA_ALERTS=true
```

---

# Log Locations

Typical log locations:

```
/var/log/suricata/

/var/log/suricata/*/alerts.log

/var/log/suricata/*/eve.json
```

Depending on the pfSense version and interface names, the exact directory may differ.

---

# Supported Alert Types

The monitoring script can detect:

- Port Scans
- Brute Force Attempts
- Malware Traffic
- DNS Attacks
- Web Attacks
- Exploit Attempts
- Protocol Violations
- Suspicious Connections
- Policy Violations

---

# Troubleshooting

## No Alerts Generated

Check:

- Interface enabled
- Rules downloaded
- Alerts enabled
- Traffic reaching the interface

---

## Script Doesn't Send Telegram Messages

Verify:

```bash
chmod +x /root/scripts/suricata_monitor.sh
```

Check

```
telegram.conf
```

Verify Cron is running.

---

## Log File Missing

Run

```bash
find /var/log/suricata -name alerts.log
```

Update the monitoring script if your installation uses a different path.

---

## Rules Never Match

Update the rules.

Restart Suricata.

Generate test traffic.

---

# Performance Tips

- Monitor only required interfaces.
- Remove unused rule categories.
- Schedule automatic rule updates.
- Review high-volume alerts regularly.
- Disable noisy rules if appropriate for your environment.

---

# Security Recommendations

- Keep rule sets updated.
- Review alerts daily.
- Investigate repeated detections.
- Combine IDS alerts with firewall logs for better visibility.
- Regularly update pfSense and the Suricata package.

---

# Verification Checklist

- [ ] Suricata installed
- [ ] Interface enabled
- [ ] Rules downloaded
- [ ] Alert logging enabled
- [ ] alerts.log exists
- [ ] Monitoring script copied
- [ ] Script executable
- [ ] Cron job configured
- [ ] Telegram notifications received

---

# Related Documentation

- [Installation Guide](Installation.md)
- [Configuration Guide](Configuration.md)
- [Telegram Setup](Telegram_Setup.md)
- [WireGuard Setup](WireGuard_Setup.md)
- [Cron Setup](Cron_Setup.md)
- [Monitoring Modules](Monitoring_Modules.md)

---

# Next Steps

Once Suricata monitoring is working:

1. Configure scheduled Cron jobs.
2. Enable all required monitoring modules.
3. Test each Telegram notification.
4. Review daily and weekly reports.
5. Explore advanced monitoring and automation features.