# Configuration Files

This directory contains example configuration files for the pfSense Telegram Monitoring Suite.

## Files

| File | Description |
|------|-------------|
| telegram.conf.example | Telegram Bot configuration |
| cron_jobs.txt | Example Cron schedule |

## Important

Do **not** commit your actual configuration files.

Copy the example files before editing.

Example:

```bash
cp telegram.conf.example telegram.conf
```

The following files are ignored by Git:

```
telegram.conf
*.local
*.secret
```