# Troubleshooting Guide

This guide provides solutions to common problems encountered while installing, configuring, and running the **pfSense Telegram Monitoring Suite**.

---

# Overview

If a monitoring module is not functioning correctly, check the following before troubleshooting:

- Scripts are executable
- Configuration files are correct
- Telegram Bot is configured
- Cron package is installed
- Required services are running
- Internet connectivity is available

---

# Quick Health Check

Run the following commands:

```sh
service cron status
```

```sh
wg show
```

```sh
ifconfig
```

```sh
ping -c 4 8.8.8.8
```

```sh
ls -l /root/scripts
```

```sh
tail -20 /var/log/system.log
```

---

# Installation Issues

## Scripts Not Found

### Error

```
No such file or directory
```

### Cause

Incorrect script path.

### Solution

Verify the scripts exist.

```sh
ls /root/scripts
```

Ensure the Cron job points to the correct path.

---

## Permission Denied

### Error

```
Permission denied
```

### Cause

Script is not executable.

### Solution

```sh
chmod +x /root/scripts/*.sh
```

Verify permissions.

```sh
ls -l /root/scripts
```

---

# Telegram Issues

## No Telegram Notifications

### Possible Causes

- Invalid Bot Token
- Incorrect Chat ID
- Internet unavailable
- Telegram blocked by firewall
- Script error

### Verify Configuration

```sh
cat config/telegram.conf
```

Check:

```
BOT_TOKEN

CHAT_ID
```

---

## Test Telegram API

```sh
curl \
https://api.telegram.org/bot<BOT_TOKEN>/getMe
```

Expected response:

```json
{
  "ok": true
}
```

---

## Invalid Bot Token

### Error

```
Unauthorized
```

### Solution

Create a new Bot Token using **BotFather** and update:

```
config/telegram.conf
```

---

## Chat ID Not Working

### Cause

The bot has never received a message.

### Solution

1. Open the bot.
2. Send `/start`.
3. Call:

```
getUpdates
```

Retrieve the correct Chat ID.

---

# Cron Issues

## Cron Jobs Never Execute

Verify Cron is running.

```sh
service cron status
```

List scheduled jobs.

```sh
crontab -l
```

Restart Cron if necessary.

```sh
service cron restart
```

---

## Script Runs Manually but Not Through Cron

Possible causes:

- Incorrect path
- Missing execute permission
- Environment differences

Use absolute paths in all Cron entries.

Example:

```text
* * * * * /root/scripts/system_monitor.sh
```

---

# WireGuard Issues

## Tunnel Down

Check:

```sh
wg show
```

Verify:

- Interface exists
- Private key configured
- Listen port correct
- Firewall allows UDP 51820

---

## Peer Never Connects

Verify:

- Public Key
- Endpoint
- Allowed IPs
- Client configuration
- Firewall rules

---

## No Handshake

Run:

```sh
wg show
```

If "Latest Handshake" is empty:

- Verify endpoint address
- Check NAT
- Confirm UDP port forwarding
- Ensure client is active

---

# Suricata Issues

## No Alerts Generated

Verify:

- Interface enabled
- Rules downloaded
- Alert logging enabled
- Suricata service running

Restart Suricata if required.

---

## alerts.log Missing

Locate the file.

```sh
find /var/log/suricata -name alerts.log
```

Update the monitoring script if the log path differs.

---

## Excessive Alerts

Reduce noise by:

- Disabling unnecessary rule categories
- Suppressing known benign alerts
- Monitoring only required interfaces

---

# System Monitoring Issues

## High CPU Usage Not Detected

Check:

```
CPU_THRESHOLD
```

in:

```
config/thresholds.conf
```

Verify the monitoring script is running every minute.

---

## Disk Usage Alerts Never Trigger

Confirm:

```sh
df -h
```

Check the configured threshold.

---

# Firewall Monitoring Issues

## No Firewall Alerts

Verify:

```sh
tail -20 /var/log/filter.log
```

Ensure firewall logging is enabled for the rules you want to monitor.

---

# Service Monitoring Issues

## Service Reported as Down

Verify manually.

Example:

```sh
service unbound status
```

Restart the service if necessary.

```sh
service unbound restart
```

---

# Configuration Monitoring Issues

## Configuration Changes Not Detected

Verify the configuration file exists.

```sh
ls /cf/conf/config.xml
```

Check the stored hash file.

```
state/config_hash
```

Delete the state file if you need to reinitialize monitoring.

---

# DHCP Monitoring Issues

## New Devices Not Detected

Verify the DHCP lease database.

```sh
cat /var/dhcpd/var/db/dhcpd.leases
```

Ensure DHCP is enabled and leases are being updated.

---

# Certificate Monitoring Issues

## Expiry Warning Never Sent

Verify certificate validity.

```sh
openssl x509 -enddate -noout -in certificate.pem
```

Check:

```
CERT_EXPIRY_DAYS
```

---

# Duplicate Notifications

### Cause

State files were removed or corrupted.

Verify:

```
state/
```

or

```
/tmp/
```

depending on the module.

Delete stale state files only if necessary.

---

# Debugging Scripts

Enable shell tracing.

```sh
sh -x /root/scripts/system_monitor.sh
```

This displays every executed command, making it easier to locate errors.

---

# Log Files

Useful log locations:

| Log | Path |
|------|------|
| System | `/var/log/system.log` |
| Firewall | `/var/log/filter.log` |
| Suricata | `/var/log/suricata/*/alerts.log` |
| DHCP | `/var/dhcpd/var/db/dhcpd.leases` |
| Cron | `/var/log/cron` (if available) |

---

# Performance Issues

If the firewall experiences high resource usage:

- Increase Cron intervals.
- Disable unused monitoring modules.
- Reduce IDS rule sets.
- Archive or rotate old log files.
- Monitor only essential interfaces.

---

# Resetting the Monitoring Suite

To reset runtime state:

1. Stop Cron jobs.
2. Remove state files.
3. Restart required services.
4. Test each script manually.
5. Re-enable Cron.

---

# Verification Checklist

- [ ] Scripts are executable
- [ ] Configuration files are valid
- [ ] Telegram Bot responds
- [ ] Internet connectivity available
- [ ] WireGuard operational
- [ ] Suricata running
- [ ] Cron jobs configured
- [ ] Notifications received
- [ ] State files updating correctly

---

# Getting Support

Before opening an issue, collect:

- pfSense version
- Package versions
- Relevant log excerpts
- Script output
- Steps to reproduce the issue

Do **not** include:

- Bot Tokens
- Chat IDs
- VPN Private Keys
- Certificates
- Sensitive configuration data

---

# Related Documentation

- Installation Guide
- Configuration Guide
- Telegram Setup
- WireGuard Setup
- Suricata Setup
- Cron Setup
- Project Architecture
- Monitoring Modules

---

# Conclusion

Following this guide should resolve most installation and runtime issues. If problems persist, review the relevant logs, verify configuration files, and test individual scripts before seeking further assistance.