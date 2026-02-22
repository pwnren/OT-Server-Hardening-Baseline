# OT-Server-Hardening-Baseline

Operational Technology (OT) server security baseline aligned with the Purdue Model and CIS compliance principles. Includes hardened Group Policy templates, administrative tiering, RDP restrictions, audit policy enforcement, logging configuration, and secure jump host architecture for compliant ICS/SCADA environments.

##  🛡 Windows Server Hardening Baseline

## 📖 Overview

This project provides a structured security baseline for hardening Windows Server environments using:

- Hardened Group Policy Objects (GPOs)
- PowerShell hardening scripts
- Attack Surface Reduction (ASR) rules
- Advanced audit policy enforcement
- Centralized logging & monitoring
- Segmentation aware access controls
---
The objective is to implement a defense in depth security posture across authentication, administrative access, network segmentation, logging, and service hardening while preserving availability requirements unique to OT environments.

---
## Scope

This baseline applies to:

- Windows Server 2016 / 2019 / 2022
- Domain-joined OT servers
- Historian servers
- Jump hosts (Level 3.5)
- Supervisory systems at Level 3/2

This baseline does not apply to:
- PLCs or embedded controllers
- Workstation HMIs without domain membership
- Vendor-managed black-box appliances
---
## Threat Model Considerations

This baseline is designed to mitigate:

- IT to OT lateral movement
- Ransomware propagation via SMB and RDP
- Credential theft and replay attacks
- Unauthorized administrative access
- Logging blind spots
- Remote exploitation of exposed services
---
## Architecture Alignment

This baseline aligns to Purdue Model segmentation principles:

Level 5 (Enterprise IT) – Domain-level identity enforcement

Level 3.5 (Industrial DMZ) – Jump host and management isolation

Level 3/2 (OT Servers) – Restricted workload access with controlled administrative paths

Administrative access is enforced through a dedicated jump host. No direct RDP from enterprise systems into OT workloads is permitted.

✅ Suitable For
- Enterprise IT environments
- Industrial / OT networks aligned with ISA/IEC 62443
- Security lab environments for validation and testing

## Identity & Authentication
- Enforced password complexity and account lockout policies
- NTLMv2 enforcement (legacy NTLM refused)
- SMBv1 disabled
- LAPS implementation for local admin control
- Restricted administrative group membership
- Built-in Administrator account hardening

## Remote Access Hardening
- RDP restricted to dedicated security group
- Network Level Authentication (NLA) required
- Idle session timeouts enforced
- Clipboard and drive redirection restrictions
- Remote Credential Guard (Jump Hosts only)

## Audit & Monitoring
- Advanced Audit Policies enabled
- Process creation logging (Event ID 4688)
- Privilege use monitoring
- Centralized SIEM log forwarding
- Security log retention sizing aligned to compliance requirements

## Service & Attack Surface Reduction
- Print Spooler disabled (where not required)
- Remote Registry disabled
- Unnecessary services removed
- Attack Surface Reduction rules enforced
- Forced restart prevention on production OT systems

🔥 Firewall Controls
- Default deny inbound policy
- Management ports restricted by source IP (Jump Host only)
- Policies aligned with segmentation design
- Role based firewall rule sets

## Deployment Model
- GPO backup templates
- PowerShell enforcement scripts
- OU design recommendations
- Deployment *should* be staged and validated in a lab prior to production rollout, particularly in OT/ICS environments.

## OT Environment Hardening Enhancements

Industrial environments require stricter uptime, segmentation, and administrative control.
- RDP allowed only from designated Jump Hosts
- No direct internet access from OT servers
- Service accounts denied interactive logon
- Controlled patch windows
- Firewall rules aligned to Purdue segmentation levels
- Strict logging for historian and jump systems

## OT Security Objectives
- Prevent lateral movement from IT to OT	
- Enforce administrative tiering and jump host isolation
- Reduce ransomware blast radius	Limit SMB, RDP, and credential exposure
- Maintain operational uptime	Avoid forced restarts and uncontrolled updates

## Hardening Control Matrix

### Identity & Authentication Controls

| Control | Risk Mitigated | Enforcement Method |
|----------|---------------|-------------------|
| Enforce Strong Password Policy | Weak credential compromise | Account Policy GPO |
| Account Lockout Policy | Brute force attacks | Account Lockout GPO |
| NTLMv2 Only | Credential downgrade attacks | Security Options GPO |
| Disable LM Hash Storage | Offline password cracking | Security Options GPO |
| Restrict Local Administrator Membership | Privilege abuse | Restricted Groups GPO |
| Implement LAPS | Shared admin password reuse | Microsoft LAPS Policy |
| Disable WDigest | Cleartext credential exposure | Registry / GPO |
| Remove Domain Admin Interactive Logon | Credential theft | Deny Logon GPO |

---

### Network & Lateral Movement Controls

| Control | Risk Mitigated | Enforcement Method |
|----------|---------------|-------------------|
| Firewall Default Deny | Unauthorized access | Windows Firewall GPO |
| Disable SMBv1 | Worm propagation | PowerShell + GPO |
| SMB Signing Required | Man-in-the-middle attacks | GPO |
| Disable NetBIOS | Reconnaissance | NIC Configuration |
| Restrict NTLM Outbound | NTLM relay attacks | Security Options GPO |
| Block Outbound Internet (OT Servers) | Command & control beaconing | Firewall Rules |
| Disable IPv6 (if unused) | Security policy bypass | NIC / Registry |

---

### Remote Access Controls

| Control | Risk Mitigated | Enforcement Method |
|----------|---------------|-------------------|
| Restrict RDP to Security Group | Lateral movement | Security Group Policy |
| Require Network Level Authentication | Credential theft | RDP Policy GPO |
| Disable Unused WinRM | Remote exploitation | GPO |
| Enforce Session Timeout | Hijacked sessions | Local Policy / GPO |

---

### Service & Attack Surface Reduction

| Control | Risk Mitigated | Enforcement Method |
|----------|---------------|-------------------|
| Disable Print Spooler | Remote exploit risk | Service Control |
| Remove Unused Roles & Features | Expanded attack surface | Server Manager / PowerShell |
| Disable TLS 1.0 / 1.1 | Crypto downgrade attacks | Registry (SCHANNEL) |
| Enforce TLS 1.2+ | Weak encryption | Registry |
| AppLocker / WDAC | Malware execution | GPO Application Control |
| Enable Defender ASR Rules | Exploit chains & ransomware | Defender Policy |
| Disable Anonymous SID Enumeration | Reconnaissance | Security Options GPO |

---

### Logging & Monitoring Controls

| Control | Risk Mitigated | Enforcement Method |
|----------|---------------|-------------------|
| Advanced Audit Logging | Lack of visibility | Advanced Audit Policy |
| Enable Process Creation Logging (4688) | Malware execution | GPO |
| Enable PowerShell Script Block Logging | Obfuscated attacks | GPO |
| Increase Security Log Size | Log overwrite | Event Log Policy |
| Centralized Log Forwarding | Blind spots | Windows Event Forwarding |
| Enable Object Access Auditing | Unauthorized file access | Advanced Audit Policy |

---

### OT Specific Security Controls

| Control | Risk Mitigated | Enforcement Method |
|----------|---------------|-------------------|
| Jump Host Enforcement | Direct PLC/server access | Tiered Admin Model |
| Historian Server Isolation | Production disruption | Firewall Segmentation |
| Block IT-to-Level 2 Routing | Plant compromise | Network ACL / Firewall |
| Disable Automatic Updates (Controlled OT Patch Cycle) | Unplanned downtime | WSUS Staging Policy |
| No Internet Access at Level 3 | Ransomware ingress | Egress Filtering |

---
## Framework Alignment

- CIS Microsoft Windows Server Benchmark
- ISA/IEC 62443-3-3 (System Security Requirements)
- NIST 800-82 (Guide to ICS Security)

