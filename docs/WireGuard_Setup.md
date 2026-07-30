#  WireGuard Setup Guide

This guide explains how to install and configure **WireGuard VPN** on pfSense and integrate it with the **pfSense Telegram Monitoring Suite**.

By the end of this guide, you will have:

- A working WireGuard tunnel
- Connected VPN peers
- Telegram notifications for VPN events
- Real-time VPN monitoring

---

# Overview

WireGuard is a modern VPN protocol that provides:

- High performance
- Strong encryption
- Simple configuration
- Low resource usage

The monitoring suite supports:

- VPN tunnel monitoring
- Peer connection alerts
- Peer disconnection alerts
- VPN traffic statistics
- Tunnel health monitoring

---

# Prerequisites

Before continuing, ensure you have:

- pfSense CE 2.7+ or pfSense Plus
- Administrator access
- Internet connection
- Telegram Bot configured
- Cron package installed

---

# Step 1 – Install WireGuard

Navigate to

```
System
    └── Package Manager
```

Search for

```
WireGuard
```

Click

```
Install
```

Wait for installation to complete.

---

# Step 2 – Create a Tunnel

Navigate to

```
VPN
    └── WireGuard
```

Click

```
Add Tunnel
```

Configure the tunnel.

Example

| Setting | Value |
|----------|-------|
| Name | HomeVPN |
| Listen Port | 51820 |
| Interface Address | 10.10.10.1/24 |

Save the configuration.

---

# Step 3 – Generate Keys

Generate:

- Private Key
- Public Key

Store them securely.

Never publish your private key.

---

# Step 4 – Create a Peer

Click

```
Add Peer
```

Example

| Setting | Value |
|----------|-------|
| Name | Laptop |
| Allowed IPs | 10.10.10.2/32 |
| Endpoint | Dynamic |

Save the peer.

---

# Step 5 – Configure Firewall Rules

Navigate to

```
Firewall
    └── Rules
```

Allow

```
UDP 51820
```

Example

| Protocol | UDP |
|-----------|-----|
| Port | 51820 |
| Action | Pass |

---

# Step 6 – Configure NAT

Navigate to

```
Firewall
    └── NAT
```

Enable outbound NAT if required for your network.

---

# Step 7 – Client Configuration

Example client configuration

```ini
[Interface]

PrivateKey = CLIENT_PRIVATE_KEY

Address = 10.10.10.2/24

DNS = 1.1.1.1


[Peer]

PublicKey = SERVER_PUBLIC_KEY

Endpoint = YOUR_PUBLIC_IP:51820

AllowedIPs = 0.0.0.0/0

PersistentKeepalive = 25
```

Replace:

- CLIENT_PRIVATE_KEY
- SERVER_PUBLIC_KEY
- YOUR_PUBLIC_IP

with your own values.

---

# Step 8 – Connect the Client

Activate the WireGuard client.

Verify the tunnel.

Example

```
Connected

Latest Handshake

2 seconds ago
```

---

# Step 9 – Test Connectivity

Ping the server.

```
ping 10.10.10.1
```

Expected

```
Reply from 10.10.10.1
```

Ping the client from pfSense.

```
ping 10.10.10.2
```

---

# Step 10 – Enable Monitoring

Copy the VPN monitoring scripts.

```
vpn_monitor.sh

vpn_peer_monitor.sh
```

Schedule them using Cron.

Example

```
* * * * * /root/scripts/vpn_monitor.sh

* * * * * /root/scripts/vpn_peer_monitor.sh
```

---

# Telegram Notifications

## Tunnel Connected

```
🟢 WireGuard Tunnel Connected

Tunnel

HomeVPN

Time

22:10
```

---

## Tunnel Disconnected

```
🔴 WireGuard Tunnel Disconnected

Tunnel

HomeVPN

Time

22:11
```

---

## Peer Connected

```
🟢 VPN Peer Connected

Peer

Laptop

Address

10.10.10.2
```

---

## Peer Disconnected

```
🔴 VPN Peer Disconnected

Peer

Laptop

Last Seen

15 seconds ago
```

---

# Monitoring Features

The VPN monitoring scripts provide:

- Tunnel status monitoring
- Peer status monitoring
- Connection state changes
- Disconnection alerts
- VPN statistics
- Duplicate alert suppression

---

# Configuration Files

Relevant configuration files:

```
config/aliases.conf

config/monitoring.conf

config/notification.conf
```

Example alias

```bash
Laptop="ABCD123456789"

Phone="XYZ987654321"
```

This displays friendly names instead of public keys.

---

# Troubleshooting

## Tunnel Won't Start

Check:

- WireGuard package installed
- Tunnel enabled
- Valid private key
- Firewall rule exists

---

## Client Cannot Connect

Verify:

- Public IP
- Listen Port
- Firewall rule
- NAT configuration
- Allowed IPs

---

## No Telegram Alerts

Verify:

- vpn_monitor.sh is executable
- Cron job is enabled
- Telegram configuration is correct

---

## Peer Never Shows Connected

Check:

```
wg show
```

Verify:

```
Latest Handshake
```

A recent handshake indicates the peer is connected.

---

# Security Recommendations

- Keep private keys confidential.
- Use strong cryptographic keys.
- Restrict firewall access to UDP 51820.
- Regularly update WireGuard and pfSense.
- Monitor VPN logs for unusual activity.

---

# Verification Checklist

- [ ] WireGuard package installed
- [ ] Tunnel created
- [ ] Peer configured
- [ ] Firewall rule added
- [ ] NAT configured
- [ ] Client connected
- [ ] Ping successful
- [ ] Telegram notifications working
- [ ] Cron jobs enabled
- [ ] VPN monitoring scripts tested

---

# Related Documentation

- [Installation Guide](Installation.md)
- [Configuration Guide](Configuration.md)
- [Telegram Setup](Telegram_Setup.md)
- [Cron Setup](Cron_Setup.md)
- [Monitoring Modules](Monitoring_Modules.md)

---

# Next Steps

Once WireGuard is working:

1. Configure Suricata IDS monitoring.
2. Enable firewall log monitoring.
3. Configure daily and weekly reports.
4. Test all monitoring modules.
5. Review the Troubleshooting guide for advanced diagnostics.