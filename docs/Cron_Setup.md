#  Cron Setup Guide

This guide explains how to configure the **Cron** package on pfSense to automatically execute the monitoring scripts included in the **pfSense Telegram Monitoring Suite**.

Cron enables scheduled execution of scripts without manual intervention.

---

# Overview

The monitoring suite uses Cron to:

- Monitor system health
- Check VPN status
- Monitor firewall events
- Monitor IDS alerts
- Check interface status
- Generate reports
- Verify backups

---

# Prerequisites

Before continuing, ensure you have:

- pfSense CE 2.7+ or pfSense Plus
- Administrator access
- Monitoring scripts installed
- Telegram Bot configured

---

# Step 1 – Install the Cron Package

Navigate to

```
System
    └── Package Manager
```

Search for

```
Cron
```

Click

```
Install
```

Wait until installation completes.

---

# Step 2 – Open the Cron Service

Navigate to

```
Services
    └── Cron
```

Click

```
Add
```

to create a new scheduled task.

---

# Step 3 – Add a Monitoring Script

Example

| Field | Value |
|-------|-------|
| Minute | * |
| Hour | * |
| Day | * |
| Month | * |
| Weekday | * |
| Command | `/root/scripts/system_monitor.sh` |

Click

```
Save
```

---

# Recommended Cron Schedule

## Every Minute

These scripts detect real-time events.

| Script | Purpose |
|---------|---------|
| system_monitor.sh | CPU, RAM, Disk |
| vpn_monitor.sh | Tunnel Status |
| vpn_peer_monitor.sh | VPN Peers |
| firewall_monitor.sh | Firewall Logs |
| suricata_monitor.sh | IDS Alerts |
| webgui_login_monitor.sh | Login Detection |
| ssh_login_monitor.sh | SSH Login Monitoring |

---

## Every 5 Minutes

| Script | Purpose |
|---------|---------|
| interface_monitor.sh | Interface Status |
| internet_monitor.sh | Internet Connectivity |
| gateway_health_monitor.sh | Gateway Latency |
| service_monitor.sh | Service Health |
| config_change_monitor.sh | Configuration Integrity |

---

## Every 15 Minutes

| Script | Purpose |
|---------|---------|
| bandwidth_monitor.sh | WAN Traffic |
| dhcp_monitor.sh | DHCP Usage |
| new_device_monitor.sh | New Devices |

---

## Hourly

| Script | Purpose |
|---------|---------|
| config_backup.sh | Backup Configuration |
| package_monitor.sh | Package Changes |

---

## Daily

Run at 01:00 AM

| Script | Purpose |
|---------|---------|
| certificate_monitor.sh | Certificate Expiry |
| daily_report.sh | Daily Health Report |

Cron Example

```
0 1 * * * /root/scripts/daily_report.sh
```

---

## Weekly

Run every Sunday at midnight.

| Script | Purpose |
|---------|---------|
| weekly_report.sh | Weekly Security Report |

Cron Example

```
0 0 * * 0 /root/scripts/weekly_report.sh
```

---

# Example Cron Table

```
* * * * * /root/scripts/system_monitor.sh

* * * * * /root/scripts/firewall_monitor.sh

* * * * * /root/scripts/vpn_monitor.sh

* * * * * /root/scripts/vpn_peer_monitor.sh

*/5 * * * * /root/scripts/interface_monitor.sh

*/5 * * * * /root/scripts/service_monitor.sh

*/15 * * * * /root/scripts/bandwidth_monitor.sh

0 * * * * /root/scripts/config_backup.sh

0 1 * * * /root/scripts/daily_report.sh

0 0 * * 0 /root/scripts/weekly_report.sh
```

---

# Testing Cron Jobs

Run a script manually.

Example

```bash
/root/scripts/system_monitor.sh
```

If successful, add it to Cron.

---

# Verify Cron Execution

SSH into pfSense.

Check whether Cron is running.

```bash
service cron status
```

List active Cron jobs.

```bash
crontab -l
```

---

# Logging

Redirect output to a log file for debugging.

Example

```bash
* * * * * /root/scripts/system_monitor.sh >> /var/log/system_monitor.log 2>&1
```

This captures both standard output and errors.

---

# Best Practices

- Keep monitoring scripts lightweight.
- Avoid running multiple heavy scripts simultaneously.
- Use state files to prevent duplicate alerts.
- Test scripts manually before scheduling.
- Group scripts by execution frequency.

---

# Troubleshooting

## Script Does Not Run

Verify:

```bash
chmod +x /root/scripts/system_monitor.sh
```

Check the script path.

---

## Permission Denied

Ensure the script is executable.

```bash
chmod +x /root/scripts/*.sh
```

---

## No Telegram Notifications

Check:

- Telegram configuration
- Internet connectivity
- Cron schedule
- Script permissions

---

## Duplicate Alerts

Most monitoring scripts use state files stored in:

```
/tmp/
```

Verify the state files are being created correctly.

---

# Performance Recommendations

Recommended intervals:

| Monitoring Type | Interval |
|-----------------|----------|
| Firewall Logs | 1 Minute |
| VPN Monitoring | 1 Minute |
| Login Monitoring | 1 Minute |
| Interface Status | 5 Minutes |
| Service Status | 5 Minutes |
| Certificate Monitoring | Daily |
| Reports | Daily / Weekly |

These values provide timely notifications while minimizing CPU usage.

---

# Verification Checklist

- [ ] Cron package installed
- [ ] Scripts copied
- [ ] Scripts executable
- [ ] Cron jobs created
- [ ] Telegram notifications working
- [ ] Manual testing completed
- [ ] Scheduled execution verified

---

# Related Documentation

- [Installation Guide](Installation.md)
- [Quick Start Guide](Quick_Start.md)
- [Configuration Guide](Configuration.md)
- [Telegram Setup](Telegram_Setup.md)
- [WireGuard Setup](WireGuard_Setup.md)
- [Suricata Setup](Suricata_Setup.md)

---

# Next Steps

Your monitoring suite is now scheduled to run automatically.

Continue with:

- **Project_Architecture.md** — Understand the system design.
- **Monitoring_Modules.md** — Learn about each monitoring script.
- **Troubleshooting.md** — Diagnose common issues.
- **Developer_Guide.md** — Extend the project with new modules.