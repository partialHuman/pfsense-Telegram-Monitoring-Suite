# Changelog

All notable changes to this project will be documented in this file.

The format is inspired by **Keep a Changelog** and follows **Semantic Versioning (SemVer)**.

---

## [1.0.0] - 2026-07-30

### 🎉 Initial Public Release

First stable release of the **pfSense Telegram Monitoring Suite**.

---

## ✨ Added

### 🖥 System Monitoring

- CPU usage monitoring
- Memory usage monitoring
- Disk usage monitoring
- System uptime monitoring
- Reboot detection
- High resource usage alerts

---

### 🌐 Network Monitoring

- WAN IP change detection
- Internet connectivity monitoring
- Gateway health monitoring
- High latency detection
- Packet loss detection
- Interface status monitoring
- Bandwidth usage monitoring

---

### 🔐 VPN Monitoring

- WireGuard tunnel status monitoring
- WireGuard peer connection detection
- WireGuard peer disconnection detection
- VPN traffic statistics
- VPN status change notifications

---

### 🛡 Firewall Monitoring

- Firewall block log monitoring
- Firewall rule modification monitoring
- Port scan detection
- Alias modification monitoring
- Interface activity monitoring

---

### 🚨 Security Monitoring

- Suricata IDS/IPS alert monitoring
- WebGUI login notifications
- Failed WebGUI login detection
- SSH login monitoring
- New device detection
- DHCP lease monitoring
- Configuration integrity monitoring

---

### ⚙ Service Monitoring

Added monitoring for

- WireGuard
- Suricata
- Unbound DNS Resolver
- DHCP Server
- SSH
- NTP

with

- Service start detection
- Service stop detection
- Service restart detection

---

### 📦 Maintenance

- Automatic configuration backup
- Backup verification
- Certificate expiry monitoring
- Package installation monitoring
- Package removal monitoring

---

### 📊 Reporting

Added

- Daily system health report
- Weekly security report

---

### 📱 Telegram Integration

Implemented

- Telegram Bot API support
- Instant notifications
- Markdown message formatting
- Emoji-based alert categories
- Rich alert messages
- Timestamped events

---

### 📁 Project Structure

Created a professional repository layout including

- README
- Documentation
- Example configuration
- Images
- Installation guide
- Requirements
- License
- GitHub-ready directory structure

---

### 📚 Documentation

Added

- Installation Guide
- Telegram Setup Guide
- WireGuard Setup Guide
- Requirements Documentation
- Example Configurations

---

## 🔒 Security

- Excluded sensitive configuration files from Git
- Added example configuration templates
- Added `.gitignore`
- Prevented accidental upload of

  - Telegram tokens
  - VPN keys
  - Certificates
  - Configuration backups

---

## ⚡ Performance

- Lightweight shell-based implementation
- Minimal CPU usage
- Low memory footprint
- Modular execution using Cron
- Duplicate alert suppression using state files

---

## 🧪 Tested

Tested on

- pfSense CE 2.7.x
- FreeBSD 14.x
- WireGuard Package
- Suricata Package
- Telegram Bot API

---

## 📂 Included Modules

| Module | Status |
|---------|:------:|
| System Monitor | ✅ |
| WAN Monitor | ✅ |
| Internet Monitor | ✅ |
| Gateway Monitor | ✅ |
| Interface Monitor | ✅ |
| VPN Monitor | ✅ |
| VPN Peer Monitor | ✅ |
| Firewall Monitor | ✅ |
| Suricata Monitor | ✅ |
| WebGUI Login Monitor | ✅ |
| SSH Login Monitor | ✅ |
| DHCP Monitor | ✅ |
| New Device Monitor | ✅ |
| Config Change Monitor | ✅ |
| Config Backup | ✅ |
| Reboot Monitor | ✅ |
| Service Monitor | ✅ |
| Certificate Monitor | ✅ |
| Package Monitor | ✅ |
| Firewall Rule Monitor | ✅ |
| Alias Monitor | ✅ |
| Port Scan Detection | ✅ |
| Daily Report | ✅ |
| Weekly Report | ✅ |

---

## 🚀 Future Roadmap

Planned for Version 1.1

- Email notifications
- Discord integration
- Slack integration
- Microsoft Teams integration
- Auto IP blocking
- GeoIP threat detection
- Threat intelligence feeds
- AI-assisted alert classification
- REST API
- Web dashboard
- Prometheus exporter
- Grafana dashboard
- HTML report generation
- PDF report generation
- Automatic incident report generation

---

## Contributors

### Version 1.0.0

- **Dhrumil Moga** — Project Design, Development, Testing, Documentation

---

## License

Released under the MIT License.