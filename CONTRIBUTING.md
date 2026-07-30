# Contributing to pfSense Telegram Monitoring Suite

First off, thank you for considering contributing to the **pfSense Telegram Monitoring Suite**! 🎉

Whether you're fixing bugs, improving documentation, adding new monitoring modules, or suggesting ideas, your contributions are greatly appreciated.

---

# Code of Conduct

Please be respectful and professional when interacting with other contributors.

We aim to create a welcoming and collaborative environment for everyone.

---

# How Can You Contribute?

There are many ways to contribute to this project:

-  Report bugs
-  Suggest new features
-  Improve documentation
-  Fix existing issues
-  Add new monitoring scripts
-  Improve security
-  Optimize performance
-  Test on different pfSense versions
-  Improve compatibility
-  Improve notification formatting

---

# Reporting Issues

Before opening an issue:

- Search existing issues first.
- Ensure the issue hasn't already been reported.
- Include enough information to reproduce the problem.

Please include:

- pfSense Version
- Package Versions
- Script Name
- Error Message
- Steps to Reproduce
- Expected Behavior
- Actual Behavior
- Relevant Logs (remove sensitive information)

Example:

```text
pfSense Version:
2.7.2

Script:
vpn_monitor.sh

Issue:
Telegram notification not sent after VPN disconnect.

Expected:
Receive disconnect alert.

Actual:
No notification received.
```

---

# Suggesting Features

Feature requests are always welcome.

Please describe:

- The problem you are trying to solve
- Why the feature is useful
- Possible implementation ideas
- Any relevant screenshots or examples

---

# Development Setup

## 1. Fork the Repository

Click the **Fork** button on GitHub.

---

## 2. Clone Your Fork

```bash
git clone https://github.com/<your-username>/pfSense-Telegram-Monitoring.git

cd pfSense-Telegram-Monitoring
```

---

## 3. Create a Branch

Use a descriptive branch name.

```bash
git checkout -b feature/new-monitor
```

Examples

```
feature/email-alerts

feature/ssh-monitor

bugfix/vpn-alert

docs/update-readme

refactor/common-library
```

---

# Coding Guidelines

## Shell Scripts

- Use POSIX-compatible shell whenever possible.
- Keep scripts modular and easy to understand.
- Add comments for complex logic.
- Use descriptive variable names.
- Avoid hardcoded values.
- Store reusable values in configuration files.
- Check command exit codes where appropriate.
- Keep scripts lightweight.

Example

```sh
CPU_USAGE=$(top -b -n 1 | awk '{print $1}')

if [ "$CPU_USAGE" -gt 90 ]; then
    send_message "High CPU Usage"
fi
```

---

# Configuration

Do **not** hardcode:

- Telegram Bot Token
- Chat ID
- VPN Keys
- Passwords
- API Keys

Use:

```
config/telegram.conf
```

instead.

---

# Folder Structure

Place files in the correct directories.

```
scripts/
```

Monitoring scripts

```
config/
```

Configuration templates

```
docs/
```

Documentation

```
images/
```

Screenshots

```
examples/
```

Sample configurations

---

# Documentation

Whenever adding a new monitoring module:

Please update:

- README.md
- CHANGELOG.md
- requirements.md
- Installation.md (if needed)

Include:

- Description
- Dependencies
- Example Output
- Configuration Steps

---

# Commit Messages

Use clear commit messages.

Good examples:

```
Add VPN peer monitoring

Fix firewall log parser

Improve Telegram formatting

Update installation guide

Optimize Suricata monitoring
```

Avoid:

```
update

changes

fix

test
```

---

# Testing

Before submitting a Pull Request, verify:

- Script executes without errors.
- Telegram notifications work correctly.
- No duplicate alerts are generated.
- Existing features continue to work.
- Documentation has been updated.

---

# Pull Request Process

1. Fork the repository.
2. Create a new branch.
3. Make your changes.
4. Test your changes.
5. Commit with a meaningful message.
6. Push your branch.
7. Open a Pull Request.

Include:

- What changed
- Why it changed
- Screenshots (if applicable)
- Test results

---

# Security Guidelines

Never commit:

- Telegram Bot Tokens
- Chat IDs
- Private Keys
- VPN Keys
- Certificates
- Passwords
- Configuration Backups
- Personal Information

Sensitive files are excluded through `.gitignore`.

---

# Areas Where Contributions Are Welcome

### Monitoring

- OpenVPN Monitoring
- IPSec Monitoring
- DNS Monitoring
- GeoIP Monitoring
- Traffic Monitoring
- Package Updates
- Hardware Monitoring

---

### Notifications

- Discord
- Slack
- Microsoft Teams
- Email
- SMS
- Webhooks

---

### Reporting

- HTML Reports
- PDF Reports
- Dashboard Improvements
- Statistics
- Weekly Reports

---

### Security

- Threat Intelligence Integration
- Auto IP Blocking
- Malware Detection
- Ransomware Detection
- AI-assisted Alert Classification

---

### Documentation

Help improve:

- Installation Guide
- Configuration Guide
- Tutorials
- Examples
- Screenshots
- Architecture Diagrams

---

# Style Guide

Please follow these conventions:

- Use meaningful file names.
- Use lowercase file names with underscores.
- Keep scripts focused on a single responsibility.
- Use consistent indentation (4 spaces or tabs consistently).
- Write clear comments only where they add value.
- Remove unused variables and dead code.

---

# Questions?

If you have any questions, feel free to:

- Open a GitHub Issue
- Start a GitHub Discussion (if enabled)
- Submit a Pull Request with your proposal

---

# Recognition

All contributors are appreciated.

Every accepted contribution helps make this project better for the pfSense and open-source communities.

Thank you for your support!