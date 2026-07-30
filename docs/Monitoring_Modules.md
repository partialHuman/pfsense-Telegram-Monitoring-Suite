#  Monitoring Modules Reference

This document describes every monitoring module included in the **pfSense Telegram Monitoring Suite**.

Each module is designed to monitor a specific aspect of the firewall and send Telegram notifications whenever important events occur.

---

# Overview

The monitoring suite consists of multiple independent shell scripts.

Each script:

- Performs one task
- Runs independently
- Uses shared libraries
- Maintains its own state
- Can be enabled or disabled individually

---

# Module Categories

| Category | Modules |
|----------|----------|
| System | CPU, RAM, Disk |
| Network | WAN, Internet, Gateway |
| VPN | Tunnel, Peer |
| Firewall | Blocks, Rules |
| IDS | Suricata |
| Authentication | WebGUI, SSH |
| DHCP | Leases, New Devices |
| Configuration | Config Changes, Backups |
| Services | DNS, DHCP, VPN, SSH |
| Certificates | Expiry |
| Reports | Daily, Weekly |

---

# 1. System Monitor

**Script**

```
system_monitor.sh
```

## Purpose

Monitors:

- CPU Usage
- Memory Usage
- Disk Usage
- System Uptime

## Data Sources

```
top

df

sysctl
```

## Configuration

```
CPU_THRESHOLD

RAM_THRESHOLD

DISK_THRESHOLD
```

## Cron

```
* * * * *
```

## Telegram Example

```
🖥 System Alert

CPU : 93%

RAM : 88%

Disk : 91%
```

---

# 2. WAN IP Monitor

**Script**

```
wan_ip_monitor.sh
```

## Purpose

Detects

- Public IP changes

## Data Source

```
ifconfig

or

External IP Service
```

## State File

```
state/wan_ip
```

## Telegram Example

```
🌐 WAN IP Changed

Old

49.xxx.xxx.xxx

New

103.xxx.xxx.xxx
```

---

# 3. Internet Connectivity Monitor

**Script**

```
internet_monitor.sh
```

## Purpose

Checks Internet connectivity.

## Method

```
Ping

1.1.1.1

8.8.8.8
```

## Telegram Example

```
🔴 Internet Connection Lost
```

or

```
🟢 Internet Connection Restored
```

---

# 4. Gateway Health Monitor

**Script**

```
gateway_monitor.sh
```

## Purpose

Monitors

- Latency
- Packet Loss

## Configuration

```
LATENCY_THRESHOLD

PACKETLOSS_THRESHOLD
```

## Example

```
⚠ Gateway Latency High

Latency

145 ms
```

---

# 5. WireGuard Tunnel Monitor

**Script**

```
vpn_monitor.sh
```

## Purpose

Detects

- Tunnel Up
- Tunnel Down

## Data Source

```
wg show
```

## Telegram

```
🟢 Tunnel Connected
```

---

# 6. WireGuard Peer Monitor

**Script**

```
vpn_peer_monitor.sh
```

## Purpose

Monitors

- Peer Connected
- Peer Disconnected
- Handshake Timeout

## State Files

```
state/vpn_peers/
```

## Example

```
🟢 Laptop Connected
```

---

# 7. Firewall Monitor

**Script**

```
firewall_monitor.sh
```

## Purpose

Detects

- Firewall Blocks
- Denied Connections

## Log Source

```
/var/log/filter.log
```

## Telegram

```
🚨 Firewall Block

Source

192.168.1.100
```

---

# 8. Firewall Rule Monitor

**Script**

```
firewall_rule_monitor.sh
```

## Purpose

Detects

- Rule Changes
- Rule Deletions
- Rule Additions

---

# 9. Interface Monitor

**Script**

```
interface_monitor.sh
```

## Purpose

Monitors

- WAN
- LAN
- OPT Interfaces

## Example

```
🔴 WAN Interface Down
```

---

# 10. Suricata Monitor

**Script**

```
suricata_monitor.sh
```

## Purpose

Monitors IDS alerts.

## Log Source

```
alerts.log
```

## Telegram

```
🚨 ET SCAN Nmap Scan Detected
```

---

# 11. WebGUI Login Monitor

**Script**

```
webgui_login_monitor.sh
```

## Purpose

Detects successful WebGUI logins.

## Log Source

```
system.log
```

---

# 12. Failed Login Monitor

**Script**

```
failed_login_monitor.sh
```

## Purpose

Detects failed WebGUI logins.

## Telegram

```
⚠ Failed Login Attempt

User

admin
```

---

# 13. SSH Login Monitor

**Script**

```
ssh_monitor.sh
```

## Purpose

Detects SSH logins.

---

# 14. DHCP Monitor

**Script**

```
dhcp_monitor.sh
```

## Purpose

Monitors DHCP lease activity.

## Database

```
dhcpd.leases
```

---

# 15. New Device Monitor

**Script**

```
device_monitor.sh
```

## Purpose

Detects newly connected devices.

## Telegram

```
📱 New Device Connected

IP

192.168.1.150
```

---

# 16. Configuration Change Monitor

**Script**

```
config_monitor.sh
```

## Purpose

Detects

- Configuration Changes

## File

```
config.xml
```

---

# 17. Configuration Backup

**Script**

```
config_backup.sh
```

## Purpose

Creates scheduled configuration backups.

---

# 18. Service Monitor

**Script**

```
service_monitor.sh
```

## Services

- Unbound
- DHCP
- SSH
- WireGuard
- Suricata
- NTP

## Telegram

```
🔴 Service Stopped

Suricata
```

---

# 19. Certificate Monitor

**Script**

```
certificate_monitor.sh
```

## Purpose

Warns before certificate expiration.

## Telegram

```
⚠ Certificate Expires in 15 Days
```

---

# 20. Package Monitor

**Script**

```
package_monitor.sh
```

## Purpose

Detects

- Installed Packages
- Removed Packages
- Updated Packages

---

# 21. Daily Report

**Script**

```
daily_report.sh
```

## Includes

- CPU
- RAM
- Disk
- VPN
- IDS
- Firewall

---

# 22. Weekly Report

**Script**

```
weekly_report.sh
```

## Includes

- Weekly Statistics
- Security Summary
- VPN Statistics
- IDS Statistics
- Firewall Statistics

---

# Shared Libraries

All monitoring modules use common libraries.

```
common.sh

telegram.sh

logger.sh

network.sh

system.sh

state.sh

config.sh
```

---

# State Files

Most modules maintain state files to avoid duplicate notifications.

Examples

```
state/

vpn_status

wan_ip

config_hash

known_devices

firewall_offset

service_status
```

---

# Notification Priority

| Priority | Example |
|----------|----------|
| Critical | VPN Down |
| High | Firewall Block |
| High | IDS Alert |
| Medium | CPU High |
| Medium | Certificate Warning |
| Low | Daily Report |

---

# Performance

Typical execution time:

| Module | Time |
|---------|------|
| System | <1 sec |
| VPN | <1 sec |
| Firewall | <2 sec |
| Suricata | <2 sec |
| Reports | 5–10 sec |

---

# Module Dependencies

```
All Modules

↓

config.sh

↓

common.sh

↓

telegram.sh

↓

logger.sh

↓

state.sh
```

---

# Best Practices

- Enable only required modules.
- Review thresholds regularly.
- Test scripts manually before enabling Cron.
- Protect configuration files containing secrets.
- Keep pfSense packages and scripts updated.

---

# Troubleshooting

If a module does not behave as expected:

1. Verify script permissions.
2. Check configuration values.
3. Inspect relevant log files.
4. Confirm Cron execution.
5. Test Telegram connectivity.
6. Review state files for stale data.

---

# Related Documentation

- Installation Guide
- Configuration Guide
- Cron Setup
- Project Architecture
- Troubleshooting
- Developer Guide