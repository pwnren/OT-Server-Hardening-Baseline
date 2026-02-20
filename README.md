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

The objective is to enforce layered defense across authentication, network access, logging, service hardening, and privilege management while maintaining operational stability in OT environments.

---
## Architecture Alignment

This baseline aligns to Purdue Model segmentation principles:

Level 5 (Enterprise IT) – Domain-level identity enforcement

Level 3.5 (Industrial DMZ) – Jump host and management isolation

Level 3/2 (OT Servers) – Restricted workload access with controlled administrative paths

Administrative access is enforced through a dedicated jump host tier. No direct lateral RDP from enterprise systems into OT workloads is permitted.

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
- Deployment *should* be staged and validated in a lab prior to production rollout, particularly in ICS environments.

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

| Control | Risk Mitigated | Enforcement Method |
|----------|---------------|-------------------|
| Disable SMBv1 | Worm propagation | PowerShell + GPO |
| NTLMv2 Only | Credential downgrade attacks | Security Option GPO |
| RDP Restriction | Lateral movement | Security group policy |
| Advanced Audit Logging | Lack of visibility | Advanced Audit Policy |
| Disable Print Spooler | Remote exploit risk | Service control |
| Firewall Default Deny | Unauthorized access | Windows Firewall GPO |
