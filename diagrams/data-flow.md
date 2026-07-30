# Data Flow Diagram

This diagram illustrates how monitoring data flows through the pfSense Telegram Monitoring Suite—from data collection to Telegram notifications and persistent state management.

```mermaid
flowchart LR

%% ===========================
%% pfSense Firewall
%% ===========================

subgraph PF["pfSense Firewall"]

subgraph MET["Metrics"]
CPU[CPU Usage]
RAM[Memory Usage]
DISK[Disk Usage]
WAN[WAN Status]
end

subgraph SEC["Security"]
FW[Firewall Logs]
SURI[Suricata Alerts]
LOGIN[Login Events]
end

subgraph NET["Network"]
WG[WireGuard]
DHCP[DHCP Leases]
CFG[Configuration]
end

end

%% ===========================
%% Monitoring Suite
%% ===========================

subgraph MON["Monitoring Suite"]

COLLECT[Data Collector]

CORE[Monitoring Core]

CONFIG[(Configuration Files)]

STATE[(State Files)]

TG[telegram.sh Library]

end

%% ===========================
%% Notification
%% ===========================

subgraph NOTIFY["Notification"]

BOT([Telegram Bot])

API[Telegram Bot API]

ADMIN([Administrator])

end

%% ===========================
%% Data Collection
%% ===========================

MET --> COLLECT
SEC --> COLLECT
NET --> COLLECT

%% ===========================
%% Monitoring Engine
%% ===========================

COLLECT --> CORE

CONFIG -- Load --> CORE

STATE -- Read --> CORE

CORE -- Write --> STATE

%% ===========================
%% Notifications
%% ===========================

CORE --> TG

TG --> BOT

BOT --> API

API --> ADMIN
```