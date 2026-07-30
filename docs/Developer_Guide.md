# Developer Guide

Welcome to the **pfSense Telegram Monitoring Suite Developer Guide**.

This document explains the project structure, coding conventions, library usage, testing methodology, and the process for creating new monitoring modules.

---

# Table of Contents

1. Introduction
2. Project Structure
3. Development Environment
4. Coding Standards
5. Shared Libraries
6. Configuration System
7. State Management
8. Creating a New Monitoring Module
9. Sending Telegram Notifications
10. Logging
11. Error Handling
12. Testing
13. Debugging
14. Performance Guidelines
15. Security Best Practices
16. Contributing
17. Release Checklist

---

# Introduction

The project is designed around **modularity**.

Every monitoring feature is implemented as an independent shell script while common functionality is placed inside reusable libraries.

Benefits include:

- Easy maintenance
- Minimal code duplication
- Easy testing
- Simple expansion
- Low resource usage

---

# Project Structure

```
pfSense-Telegram-Monitoring/

├── config/
├── docs/
├── examples/
├── images/
├── lib/
├── logs/
├── reports/
├── scripts/
├── state/

├── README.md
├── LICENSE
└── CHANGELOG.md
```

---

# Directory Overview

## scripts/

Contains all monitoring modules.

Example

```
system_monitor.sh

vpn_monitor.sh

firewall_monitor.sh
```

---

## lib/

Contains reusable functions.

```
common.sh

telegram.sh

logger.sh

network.sh

system.sh

config.sh

state.sh
```

---

## config/

Stores user-editable configuration.

```
telegram.conf

thresholds.conf

services.conf
```

---

## state/

Stores runtime state.

Example

```
vpn_status

wan_ip

known_devices

config_hash
```

---

# Development Environment

Recommended tools:

- pfSense CE 2.7+
- ShellCheck
- Visual Studio Code
- Git
- GitHub
- SSH Client

Useful VS Code extensions:

- ShellCheck
- Bash IDE
- GitLens

---

# Coding Standards

## Script Header

Every script should begin with:

```sh
#!/bin/sh
#
# Script Name:
#
# Description:
#
# Author:
#
# License: MIT
#
```

---

## Variable Naming

Use uppercase for constants.

```sh
CPU_THRESHOLD=90
```

Use lowercase for local variables.

```sh
cpu_usage=85
```

---

## Function Naming

Use descriptive names.

Good

```sh
send_telegram()

get_cpu_usage()

save_state()
```

Avoid

```sh
test()

abc()

run()
```

---

# Shared Libraries

Each monitoring module should load required libraries.

```sh
. /root/lib/common.sh

. /root/lib/logger.sh

. /root/lib/state.sh

. /root/lib/telegram.sh
```

Do not duplicate functions already available in the `lib/` directory.

---

# Configuration System

Never hardcode values.

Incorrect

```sh
BOT_TOKEN="ABC"
```

Correct

```sh
. /root/config/telegram.conf
```

All configurable values should reside in the `config/` directory.

---

# State Management

State files prevent duplicate alerts.

Example

```sh
STATE_FILE="/root/state/vpn_status"
```

Read previous state.

```sh
old_state=$(cat "$STATE_FILE" 2>/dev/null)
```

Save current state.

```sh
echo "$current_state" > "$STATE_FILE"
```

---

# Creating a New Monitoring Module

Example workflow:

```
Identify event

↓

Create script

↓

Load libraries

↓

Collect data

↓

Compare previous state

↓

Send Telegram alert

↓

Save new state

↓

Exit
```

---

## Example Skeleton

```sh
#!/bin/sh

. /root/lib/config.sh
. /root/lib/logger.sh
. /root/lib/state.sh
. /root/lib/telegram.sh

main() {

    # Collect data

    # Compare state

    # Send notification

    # Save state

}

main
```

---

# Telegram Notifications

Always use the shared helper.

Example

```sh
send_telegram "Firewall Alert" "Blocked connection detected."
```

Avoid direct API calls inside individual monitoring scripts.

---

# Logging

Use the shared logging library.

```sh
log_info "Monitoring started"

log_warning "CPU threshold exceeded"

log_error "Unable to read log file"
```

---

# Error Handling

Always verify:

- Files exist
- Commands succeed
- Required services are available

Example

```sh
if [ ! -f "$LOG_FILE" ]; then
    log_error "Log file not found."
    exit 1
fi
```

---

# Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Success |
| 1 | General Error |
| 2 | Invalid Configuration |
| 3 | Dependency Missing |
| 4 | Permission Error |

---

# Testing

Before committing:

- Run manually
- Verify Telegram notification
- Check state file updates
- Review log output
- Confirm Cron compatibility

Example

```sh
sh -x scripts/system_monitor.sh
```

---

# Debugging

Enable shell tracing.

```sh
set -x
```

Disable tracing.

```sh
set +x
```

Use ShellCheck.

```sh
shellcheck scripts/system_monitor.sh
```

---

# Performance Guidelines

Monitoring scripts should:

- Execute quickly
- Minimize external commands
- Reuse shared libraries
- Avoid unnecessary loops
- Read only required log entries

---

# Security Best Practices

Never commit:

- Bot tokens
- Chat IDs
- VPN private keys
- Certificates
- Backup files
- Configuration files containing secrets

Use `.example` files for templates.

---

# Documentation

Every new module should include:

- Purpose
- Configuration
- Cron schedule
- Example notification
- Troubleshooting
- Required dependencies

Update:

- README.md
- Monitoring_Modules.md
- CHANGELOG.md

---

# Contributing Workflow

```
Fork Repository

↓

Create Feature Branch

↓

Develop

↓

Test

↓

Update Documentation

↓

Commit Changes

↓

Push Branch

↓

Open Pull Request

↓

Code Review

↓

Merge
```

---

# Commit Message Format

Examples

```
feat: add gateway latency monitor

fix: prevent duplicate VPN alerts

docs: update installation guide

refactor: simplify state handling

test: improve firewall monitor coverage
```

---

# Pull Request Checklist

Before opening a Pull Request:

- [ ] Code tested
- [ ] ShellCheck passes
- [ ] Documentation updated
- [ ] No secrets committed
- [ ] CHANGELOG updated
- [ ] Scripts executable
- [ ] Notifications verified

---

# Release Checklist

Before a release:

- [ ] Update version
- [ ] Update CHANGELOG
- [ ] Test all monitoring modules
- [ ] Verify installation guide
- [ ] Verify example configuration files
- [ ] Review security documentation
- [ ] Create GitHub release

---

# Best Practices

- Keep modules focused on a single responsibility.
- Reuse shared libraries whenever possible.
- Prefer configuration over hardcoded values.
- Maintain backward compatibility where practical.
- Document all new features.

---

# Related Documentation

- Installation Guide
- Configuration Guide
- Monitoring Modules
- Project Architecture
- Contributing Guide
- Security Policy

---

# Conclusion

The modular design of the **pfSense Telegram Monitoring Suite** makes it straightforward to extend, maintain, and contribute. By following the conventions outlined in this guide, developers can add new monitoring capabilities while preserving consistency, reliability, and performance across the project.