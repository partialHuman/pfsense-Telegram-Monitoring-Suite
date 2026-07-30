```mermaid
flowchart TD

Cron[Cron Scheduler]

Cron -->|Every Minute| System[System Monitor]
Cron -->|Every Minute| WAN[WAN Monitor]
Cron -->|Every Minute| Firewall[Firewall Monitor]
Cron -->|Every Minute| WireGuard[WireGuard Monitor]
Cron -->|Every Minute| Suricata[Suricata Monitor]

Cron -->|Daily| Daily[Daily Report]

Cron -->|Weekly| Weekly[Weekly Report]
```