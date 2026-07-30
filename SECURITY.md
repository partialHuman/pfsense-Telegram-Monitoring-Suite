# Security Policy

## Supported Versions

The following table shows the currently supported versions of the **pfSense Telegram Monitoring Suite**.

| Version | Supported |
| :------: | :-------: |
| 1.x | ✅ Yes |
| < 1.0 | ❌ No |

Only the latest stable release receives security updates and bug fixes.

---

# Reporting a Security Vulnerability

If you discover a security vulnerability, **please do not create a public GitHub issue**.

Instead, report it privately by contacting the project maintainer.

Include the following information:

- Description of the vulnerability
- Steps to reproduce
- Impact assessment
- Affected version(s)
- Suggested fix (if available)
- Screenshots or logs (if applicable)

Please **remove all sensitive information** before submitting any logs or screenshots.

---

# Response Timeline

We aim to respond according to the following timeline:

| Action | Target Time |
|---------|------------|
| Initial acknowledgment | Within 48 hours |
| Initial assessment | Within 5 business days |
| Security fix (critical issues) | As soon as possible |
| Public disclosure | After a fix is available |

---

# Scope

This security policy applies to:

- Shell scripts
- Configuration templates
- Telegram integration
- Monitoring modules
- Documentation
- GitHub repository

---

# Security Best Practices

## Protect Your Telegram Bot Token

Your Telegram Bot Token grants full access to your bot.

**Never:**

- Commit it to Git
- Share it publicly
- Include it in screenshots
- Post it in GitHub Issues

Store it in:

```text
config/telegram.conf
```

Example:

```bash
BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="YOUR_CHAT_ID"
```

The actual configuration file should **never** be committed to the repository.

---

## Protect VPN Keys

Never upload:

- WireGuard private keys
- OpenVPN private keys
- IPSec secrets
- VPN configuration containing credentials

Example files that should remain private:

```text
privatekey
wg_private.key
server.conf
client.conf
```

---

## Protect Certificates

Do not upload:

- Private certificates
- Certificate authorities
- PKCS#12 bundles
- Private SSL keys

Example:

```text
*.pem
*.key
*.p12
*.pfx
```

---

## Protect pfSense Configuration

Your `config.xml` contains sensitive information such as:

- User accounts
- Password hashes
- VPN configuration
- Firewall rules
- Certificates
- Network settings

Never upload:

```text
config.xml
backup.xml
```

---

# Secrets Management

Never hardcode:

- Passwords
- API keys
- Telegram tokens
- Chat IDs
- VPN credentials
- SSH keys

Instead, store secrets in local configuration files that are ignored by Git.

Example:

```bash
config/telegram.conf
```

---

# Git Security

Before pushing changes:

Run:

```bash
git status
```

Verify that no sensitive files are staged.

Review:

```bash
git diff
```

If a secret was accidentally committed:

1. Revoke the exposed credential immediately.
2. Generate a new credential.
3. Remove the secret from Git history.
4. Force-push only if appropriate and after understanding the impact.

---

# Secure Deployment

Before deploying:

- Change all default passwords.
- Enable HTTPS for the pfSense WebGUI.
- Restrict WebGUI access to trusted networks.
- Enable strong administrator passwords.
- Keep pfSense updated.
- Keep installed packages updated.

---

# Telegram Security

Use a private Telegram chat or a private group for alerts.

Avoid sending:

- Passwords
- Private keys
- Full configuration files
- Personally identifiable information (PII)

---

# File Permissions

Recommended permissions:

```bash
chmod 600 config/telegram.conf
chmod 700 /root/scripts
chmod +x /root/scripts/*.sh
```

---

# Firewall Recommendations

Allow outbound access only where required.

Required outbound destination:

```text
https://api.telegram.org
```

Restrict unnecessary inbound access to:

- SSH
- WebGUI
- VPN services

---

# Logging

Logs may contain:

- Public IP addresses
- Internal IP addresses
- Usernames
- Interface names
- Service status

Review logs before sharing them publicly.

Redact sensitive information whenever possible.

---

# Third-Party Software

This project may integrate with:

- pfSense
- WireGuard
- Suricata
- pfBlockerNG
- Telegram Bot API
- Cron

Keep these components updated to the latest stable versions.

---

# Responsible Disclosure

Please allow reasonable time for vulnerabilities to be investigated and fixed before publicly disclosing them.

Responsible disclosure helps protect users while a fix is being prepared.

---

# Known Security Limitations

This project:

- Does not encrypt Telegram messages end-to-end beyond Telegram's platform capabilities.
- Relies on HTTPS connectivity to the Telegram Bot API.
- Stores temporary runtime state in local files.
- Does not transmit firewall logs to third-party services other than Telegram (when configured).

---

# Security Checklist

Before publishing or deploying:

- [ ] Remove all secrets from the repository.
- [ ] Verify `.gitignore` is working correctly.
- [ ] Replace real configuration files with `.example` versions.
- [ ] Confirm no VPN keys are included.
- [ ] Confirm no certificates are included.
- [ ] Confirm no `config.xml` backups are included.
- [ ] Verify Telegram notifications work using test credentials.
- [ ] Review logs for sensitive information.

---

# Dependencies

Keep the following updated:

- pfSense
- WireGuard
- Suricata
- Cron package
- Telegram Bot API integration
- Shell scripts

---

# Contact

If you believe you have found a security issue, please contact the project maintainer privately before opening a public issue.

Thank you for helping keep the **pfSense Telegram Monitoring Suite** secure for everyone.