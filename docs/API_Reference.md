# API Reference

This document describes the internal functions, libraries, and APIs used by the **pfSense Telegram Monitoring Suite**.

The project is built around reusable shell libraries located in the `lib/` directory. Monitoring modules should use these functions instead of implementing duplicate logic.

---

# Table of Contents

1. Library Overview
2. common.sh
3. config.sh
4. telegram.sh
5. logger.sh
6. network.sh
7. system.sh
8. state.sh
9. validator.sh
10. colors.sh
11. Exit Codes

---

# Library Overview

```
lib/

├── common.sh
├── config.sh
├── telegram.sh
├── logger.sh
├── network.sh
├── system.sh
├── state.sh
├── validator.sh
└── colors.sh
```

Every monitoring module should load only the libraries it requires.

Example

```sh
. /root/lib/config.sh
. /root/lib/logger.sh
. /root/lib/state.sh
. /root/lib/telegram.sh
```

---

# common.sh

General utility functions used throughout the project.

---

## timestamp()

Returns the current date and time.

### Syntax

```sh
timestamp
```

### Returns

```
2026-07-31 10:45:17
```

---

## separator()

Prints a visual separator line.

### Syntax

```sh
separator
```

### Example

```
----------------------------------------
```

---

## file_exists()

Checks whether a file exists.

### Syntax

```sh
file_exists "/var/log/system.log"
```

### Return

| Code | Meaning |
|------|---------|
| 0 | Exists |
| 1 | Not Found |

---

## command_exists()

Checks whether a command is available.

### Syntax

```sh
command_exists curl
```

---

# config.sh

Loads project configuration files.

---

## load_config()

Loads every configuration file from the `config/` directory.

### Syntax

```sh
load_config
```

Automatically loads

```
telegram.conf

monitoring.conf

thresholds.conf

services.conf

notification.conf
```

---

# telegram.sh

Handles all Telegram communication.

---

## send_telegram()

Sends a Telegram message.

### Syntax

```sh
send_telegram "Title" "Message"
```

### Example

```sh
send_telegram \
"Firewall Alert" \
"Blocked connection detected."
```

---

## test_telegram()

Tests Telegram connectivity.

### Syntax

```sh
test_telegram
```

### Returns

```
Success

or

Failure
```

---

# logger.sh

Logging functions.

---

## log_info()

Logs informational messages.

### Syntax

```sh
log_info "Cron started."
```

---

## log_warning()

Logs warnings.

### Syntax

```sh
log_warning "CPU usage high."
```

---

## log_error()

Logs errors.

### Syntax

```sh
log_error "Unable to read configuration."
```

---

## log_debug()

Prints debug messages when debug mode is enabled.

### Syntax

```sh
log_debug "VPN state changed."
```

---

# network.sh

Network utility functions.

---

## internet_up()

Checks Internet connectivity.

### Syntax

```sh
internet_up
```

### Return

| Code | Meaning |
|------|---------|
| 0 | Internet Available |
| 1 | Offline |

---

## get_wan_ip()

Returns the current WAN IP.

### Syntax

```sh
get_wan_ip
```

### Example

```
103.xxx.xxx.xxx
```

---

## gateway_latency()

Measures gateway latency.

### Syntax

```sh
gateway_latency
```

### Example

```
14 ms
```

---

## packet_loss()

Measures packet loss.

### Syntax

```sh
packet_loss
```

### Example

```
0%
```

---

## interface_up()

Checks interface status.

### Syntax

```sh
interface_up em0
```

---

# system.sh

System monitoring functions.

---

## cpu_usage()

Returns CPU utilization.

### Syntax

```sh
cpu_usage
```

### Example

```
17
```

---

## memory_usage()

Returns RAM utilization.

### Syntax

```sh
memory_usage
```

---

## disk_usage()

Returns filesystem usage.

### Syntax

```sh
disk_usage
```

---

## system_uptime()

Returns uptime.

### Syntax

```sh
system_uptime
```

### Example

```
14 Days
```

---

# state.sh

Functions for runtime state management.

---

## get_state()

Reads a state value.

### Syntax

```sh
get_state vpn_status
```

---

## save_state()

Stores a state value.

### Syntax

```sh
save_state vpn_status up
```

---

## delete_state()

Deletes a state file.

### Syntax

```sh
delete_state vpn_status
```

---

## state_exists()

Checks if a state file exists.

### Syntax

```sh
state_exists vpn_status
```

---

# validator.sh

Validation helpers.

---

## validate_config()

Checks required configuration values.

### Syntax

```sh
validate_config
```

---

## validate_dependencies()

Verifies required commands.

Checks examples:

```
curl

grep

awk

sed

wg
```

---

# colors.sh

ANSI terminal colors.

---

## color_info()

Returns informational color.

---

## color_warning()

Returns warning color.

---

## color_error()

Returns error color.

---

## color_success()

Returns success color.

---

# Return Codes

| Code | Description |
|------|-------------|
| 0 | Success |
| 1 | General Error |
| 2 | Invalid Configuration |
| 3 | Missing Dependency |
| 4 | Network Error |
| 5 | Permission Error |

---

# Error Handling

All library functions should:

- Return meaningful exit codes.
- Log descriptive error messages.
- Avoid exposing sensitive information.
- Exit gracefully on failure.

Example:

```sh
if ! internet_up; then
    log_error "Internet connectivity unavailable."
    exit 4
fi
```

---

# Usage Example

A typical monitoring script uses several shared APIs:

```sh
#!/bin/sh

. /root/lib/config.sh
. /root/lib/logger.sh
. /root/lib/state.sh
. /root/lib/system.sh
. /root/lib/telegram.sh

load_config

cpu=$(cpu_usage)

if [ "$cpu" -gt "$CPU_THRESHOLD" ]; then
    send_telegram \
        "High CPU Usage" \
        "CPU usage is ${cpu}%."
fi
```

---

# Best Practices

- Use shared library functions instead of duplicate code.
- Keep APIs backward compatible.
- Validate input parameters.
- Return consistent exit codes.
- Document any new public functions before merging changes.

---

# Versioning

Changes to public library functions should be reflected in:

- `CHANGELOG.md`
- `Developer_Guide.md`
- This `API_Reference.md`

Deprecated functions should remain available for at least one minor release whenever possible.

---

# Related Documentation

- Developer Guide
- Project Architecture
- Monitoring Modules
- Contributing Guide