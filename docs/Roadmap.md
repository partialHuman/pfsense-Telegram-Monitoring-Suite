#  Project Roadmap

The **pfSense Telegram Monitoring Suite** is actively developed with the goal of providing a lightweight, modular, and enterprise-grade monitoring framework for pfSense firewalls.

This roadmap outlines planned features, improvements, and long-term goals.

---

# Vision

Build a complete monitoring ecosystem for **pfSense**, providing:

- Real-time monitoring
- Security event detection
- VPN monitoring
- Automated reporting
- Multi-platform notifications
- Extensible plugin architecture

---

# Release Timeline

```text
v1.0  → Stable Monitoring Suite
v1.1  → Enhanced Notifications
v1.2  → Dashboard Integration
v2.0  → Enterprise Features
v3.0  → Distributed Monitoring
```

---

# Version 1.0 (Current)

## Core Monitoring

- [x] CPU Monitoring
- [x] Memory Monitoring
- [x] Disk Monitoring
- [x] WAN Connectivity Monitoring
- [x] Gateway Latency Monitoring

---

## Security

- [x] Firewall Log Monitoring
- [x] Login Monitoring
- [x] SSH Login Monitoring
- [x] Configuration Change Detection

---

## VPN

- [x] WireGuard Tunnel Monitoring
- [x] Peer Handshake Monitoring
- [x] Tunnel Status Alerts

---

## IDS / IPS

- [x] Suricata Alert Monitoring
- [x] Alert Severity Parsing

---

## Services

- [x] Service Status Monitoring
- [x] Automatic Restart Detection

---

## DHCP

- [x] New Device Detection
- [x] Lease Monitoring

---

## Reporting

- [x] Daily Report
- [x] Weekly Report

---

## Documentation

- [x] Installation Guide
- [x] Configuration Guide
- [x] API Reference
- [x] Developer Guide
- [x] Architecture Diagrams
- [x] Troubleshooting Guide

---

# Version 1.1

## Notifications

- [ ] Discord Notifications
- [ ] Slack Notifications
- [ ] Webhook Support

---

## Monitoring

- [ ] Certificate Renewal Alerts
- [ ] Package Update Alerts
- [ ] Interface Bandwidth Monitoring
- [ ] Gateway Packet Loss History
- [ ] DNS Health Monitoring

---

## Reports

- [ ] Monthly Reports
- [ ] HTML Reports
- [ ] CSV Export

---

# Version 1.2

## Dashboard

- [ ] Grafana Dashboard
- [ ] InfluxDB Integration
- [ ] Prometheus Exporter
- [ ] Historical Charts

---

## Monitoring

- [ ] Network Throughput Graphs
- [ ] Interface Statistics
- [ ] Top Talkers
- [ ] Traffic Analysis

---

## User Experience

- [ ] Interactive Installer
- [ ] Automatic Configuration Wizard
- [ ] Web Configuration Page

---

# Version 2.0

## Enterprise Features

- [ ] Multi-Firewall Monitoring
- [ ] Central Management Server
- [ ] Role-Based Access Control
- [ ] High Availability Monitoring

---

## Security

- [ ] Threat Intelligence Feeds
- [ ] GeoIP Analysis
- [ ] Brute Force Detection
- [ ] Malware Alert Correlation

---

## Automation

- [ ] Auto Ticket Creation
- [ ] Automatic Firewall Rule Suggestions
- [ ] Automated Incident Response

---

# Version 3.0

## Cloud Integration

- [ ] Cloud Dashboard
- [ ] REST API
- [ ] Mobile Application
- [ ] Push Notifications

---

## Artificial Intelligence

- [ ] AI Alert Prioritization
- [ ] Anomaly Detection
- [ ] Predictive Failure Analysis
- [ ] Smart Alert Suppression

---

## Distributed Monitoring

- [ ] Multiple Site Monitoring
- [ ] Site Health Dashboard
- [ ] Cross-Site Reporting

---

# Long-Term Ideas

## Integrations

- [ ] Zabbix
- [ ] Nagios
- [ ] LibreNMS
- [ ] PRTG
- [ ] Home Assistant

---

## VPN

- [ ] OpenVPN Monitoring
- [ ] IPSec Monitoring
- [ ] Tailscale Monitoring
- [ ] ZeroTier Monitoring

---

## Notifications

- [ ] SMS Gateway
- [ ] Signal
- [ ] Matrix
- [ ] Mattermost

---

## Platform Support

- [ ] OPNsense Support
- [ ] FreeBSD Monitoring
- [ ] Docker Deployment
- [ ] Kubernetes Deployment

---

# Contribution Opportunities

Contributors are especially welcome to help with:

- Notification integrations
- Dashboard development
- Documentation improvements
- Testing on different pfSense versions
- Performance optimization
- Localization

---

# Roadmap Status

| Version | Status |
|---------|--------|
| v1.0 | ✅ Stable |
| v1.1 | 🚧 Planned |
| v1.2 | 📋 Design |
| v2.0 | 💡 Future |
| v3.0 | 🌍 Vision |

---

# Success Metrics

The project aims to achieve:

- Less than 1% false alerts
- Script execution under 1 second
- Minimal CPU and memory usage
- Modular, reusable codebase
- Comprehensive documentation
- Easy installation and maintenance

---

# Community Feedback

The roadmap evolves based on:

- User feedback
- Feature requests
- Security trends
- pfSense updates
- Community contributions

Suggestions and pull requests are always welcome.

---

# Related Documentation

- README.md
- CHANGELOG.md
- CONTRIBUTING.md
- Developer_Guide.md
- Release_Process.md