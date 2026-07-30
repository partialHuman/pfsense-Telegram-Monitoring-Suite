# Library Modules

The `lib/` directory contains reusable shell libraries shared by all monitoring scripts.

## Modules

| File | Description |
|------|-------------|
| common.sh | Common helper functions |
| telegram.sh | Telegram Bot API functions |
| config.sh | Loads project configuration |
| logger.sh | Logging utilities |
| network.sh | Network helper functions |
| system.sh | System information helpers |
| state.sh | State file management |
| validator.sh | Dependency and configuration validation |
| colors.sh | Terminal color definitions |

## Usage

Source the required libraries at the beginning of your script:

```bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

. "$SCRIPT_DIR/../lib/config.sh"
. "$SCRIPT_DIR/../lib/common.sh"
. "$SCRIPT_DIR/../lib/telegram.sh"
```

Keeping shared functionality in `lib/` reduces duplicated code, improves readability, and makes maintenance easier across all monitoring modules.