# Frequently Asked Questions (FAQ)

This document answers the most commonly asked questions about the **pfSense Telegram Monitoring Suite**.

---

# General Questions

## What is the pfSense Telegram Monitoring Suite?

The pfSense Telegram Monitoring Suite is a collection of lightweight shell scripts that monitor various aspects of a pfSense firewall and send real-time notifications through the Telegram Bot API.

It provides monitoring for:

- System resources
- Firewall events
- WireGuard VPN
- Suricata IDS
- DHCP
- Services
- Certificates
- Configuration changes
- Daily and weekly reports

---

## Which pfSense versions are supported?

Supported versions:

- pfSense CE 2.7+
- pfSense Plus (latest supported releases)

Older versions may work but are not officially tested.

---

## Which operating system does this project support?

This project is designed specifically for **pfSense**, which is based on **FreeBSD**.

It has not been tested on:

- Linux
- OpenWrt
- OPNsense
- MikroTik RouterOS

Although many scripts may work on other FreeBSD-based systems with minor modifications.

---

## Is this project free?

Yes.

The project is released under the MIT License and may be freely used, modified, and distributed according to the license terms.

---

# Installation

## Do I need additional packages?

Yes.

Recommended packages include:

- Cron
- WireGuard (optional)
- Suricata (optional)
- curl

---

## Can I install only selected monitoring modules?

Yes.

Every monitoring script is independent.

Simply disable unwanted modules in:

```
config/monitoring.conf
```

or remove their Cron jobs.

---

## Where should the scripts be installed?

Recommended location:

```
/root/scripts/
```

Shared libraries:

```
/root/lib/
```

Configuration:

```
/root/config/
```

---

# Telegram

## Why am I not receiving Telegram notifications?

Check the following:

- Bot Token is valid
- Chat ID is correct
- Internet connectivity is available
- Telegram bot has been started
- Cron is executing the script

---

## How do I find my Chat ID?

1. Start your bot.
2. Send a message.
3. Visit:

```
https://api.telegram.org/bot<BOT_TOKEN>/getUpdates
```

Your Chat ID will appear in the response.

---

## Can I send alerts to a Telegram group?

Yes.

Add the bot to the group, send a message, retrieve the group Chat ID, and update:

```
CHAT_ID="-100xxxxxxxxxx"
```

---

# WireGuard

## How are VPN peers detected?

The monitoring script uses:

```
wg show
```

to retrieve the latest handshake information.

If a peer's handshake changes, the script determines whether the peer has connected or disconnected.

---

## Why am I receiving duplicate VPN alerts?

Possible causes:

- State files were deleted.
- Monitoring script restarted without state.
- Incorrect state file path.

Verify the contents of the `state/` directory.

---

# Suricata

## Why are no IDS alerts being generated?

Check:

- Interface enabled
- Rules downloaded
- Alert logging enabled
- Suricata service running

Generate test traffic using tools such as Nmap to verify detection.

---

## Which rule sets are supported?

The project works with any Suricata-compatible rule set, including:

- Emerging Threats Open
- Snort Community Rules (if available)
- Custom local rules

---

# Monitoring

## Can I disable individual monitoring modules?

Yes.

Edit:

```
config/monitoring.conf
```

Example:

```bash
ENABLE_SURICATA_MONITOR=false
```

---

## How often should the scripts run?

Recommended intervals:

| Module | Interval |
|---------|----------|
| Firewall | Every minute |
| VPN | Every minute |
| System | Every minute |
| Services | Every 5 minutes |
| Reports | Daily / Weekly |

---

## Can I change the alert thresholds?

Yes.

Modify:

```
config/thresholds.conf
```

Example:

```bash
CPU_THRESHOLD=95

RAM_THRESHOLD=90

DISK_THRESHOLD=85
```

---

# Development

## Can I add my own monitoring modules?

Yes.

The project is modular.

Create a new script inside:

```
scripts/
```

Reuse functions from:

```
lib/
```

Update:

- Monitoring_Modules.md
- CHANGELOG.md
- README.md

---

## Can I use another notification service?

The project currently supports Telegram.

Additional services such as:

- Discord
- Slack
- Microsoft Teams
- Email
- Mattermost

can be added by implementing new notification libraries.

---

## Can I replace Telegram completely?

Yes.

Create a new notification library (for example, `discord.sh`) and update monitoring scripts to use the new interface.

---

# Security

## Are my Telegram Bot Token and Chat ID stored securely?

They are stored in:

```
config/telegram.conf
```

This file should **never** be committed to Git.

Only commit:

```
telegram.conf.example
```

---

## Should VPN private keys be stored in Git?

No.

Never commit:

- VPN private keys
- Certificates
- Bot Tokens
- Chat IDs
- Configuration backups

---

# Performance

## Will this affect pfSense performance?

No.

The monitoring scripts are lightweight.

Typical resource usage:

- CPU: Less than 2%
- Memory: Less than 50 MB

Performance depends on:

- Number of monitoring modules
- Cron frequency
- Volume of log activity

---

## Can I monitor multiple firewalls?

Yes.

You can deploy the monitoring suite on multiple pfSense installations.

Use:

- Separate Telegram bots, or
- Separate Telegram groups

to distinguish alerts.

---

# Updates

## How do I update the project?

1. Pull the latest changes from Git.
2. Review `CHANGELOG.md`.
3. Update configuration files if needed.
4. Test all monitoring scripts.
5. Restart scheduled Cron jobs if required.

---

## Will updates overwrite my configuration?

Configuration template files may change, but your local configuration should be preserved.

Compare your configuration with the updated `.example` files after upgrading.

---

# Troubleshooting

## Scripts work manually but not through Cron.

Possible causes:

- Incorrect path
- Missing execute permission
- Cron service not running

Verify:

```sh
service cron status
```

---

## How do I reset the monitoring suite?

1. Stop Cron.
2. Remove runtime state files.
3. Restart services.
4. Test scripts manually.
5. Re-enable Cron.

---

# Contributing

## How can I contribute?

You can contribute by:

- Reporting bugs
- Improving documentation
- Adding monitoring modules
- Fixing issues
- Reviewing pull requests

Please read:

```
CONTRIBUTING.md
```

before submitting changes.

---

# Licensing

## What license does this project use?

The project uses the **MIT License**.

See:

```
LICENSE
```

for complete terms.

---

# Need More Help?

If your question is not answered here:

1. Read the documentation in the `docs/` directory.
2. Check `Troubleshooting.md`.
3. Search existing GitHub Issues.
4. Open a new issue with detailed information, including your pfSense version, package versions, relevant logs, and steps to reproduce the problem (without sharing secrets such as Bot Tokens or private keys).