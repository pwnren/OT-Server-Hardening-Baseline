OT-Server-Hardening-Baseline

Operational Technology (OT) server security baseline aligned with the Purdue Model and STIG/CIS compliance principles. Includes hardened Group Policy templates, administrative tiering, RDP restrictions, audit policy enforcement, logging configuration, and secure jump host architecture for compliant ICS/SCADA environments.

# 🛡 Windows Server Hardening Baseline

## 📖 Overview

This project provides a structured security baseline for hardening Windows Server environments using:

- Hardened Group Policy Objects (GPOs)
- PowerShell hardening scripts
- Attack Surface Reduction (ASR) rules
- Advanced audit policy enforcement
- Centralized logging & monitoring
- Segmentation aware access controls

The objective is to implement layered defense across authentication, network access, logging, service hardening, and privilege management.

---

## ✅ Suitable For

- Enterprise IT environments
- Industrial / OT networks aligned with ISA/IEC 62443 and Purdue Model
- Security lab environments for practice and validation

---

# Core Security Domains

## Identity & Authentication

- Enforced password complexity and account lockout
- NTLMv2 enforcement (disable legacy NTLM)
- SMBv1 disabled
- LAPS implementation
- Restricted administrative groups
- Built-in Administrator account hardening

---

## Remote Access Hardening

- RDP restricted to dedicated security group
- Network Level Authentication (NLA) required
- Idle session timeouts enforced
- Clipboard and drive redirection restrictions

---

## Audit & Monitoring

- Advanced Audit Policies enabled
- Process creation logging (Event ID 4688)
- Privilege use monitoring
- SIEM log forwarding configuration

---

## Service & Attack Surface Reduction

- Print Spooler disabled (where not required)
- Remote Registry disabled
- Unnecessary services removed
- Attack Surface Reduction policies enforced

---

## Firewall Controls

- Default deny inbound policy
- Management ports restricted by source IP
- Policies aligned with segmentation design
- Role-based firewall rule sets

---

## Deployment Model

This project includes:

- GPO backup templates
- PowerShell enforcement scripts
- OU design recommendations
- Hardening control mapping

> ⚠️ Deployment should be staged and validated in a lab environment prior to production rollout.

---

## Philosophy

This baseline follows a **Defense in depth** model:

- Reduce attack surface
- Restrict privilege
- Enforce logging
- Prevent lateral movement
- Align with compliance frameworks

---

# OT Environment Hardening Enhancements

Industrial environments require stricter uptime, segmentation, and access controls.

## Additional Controls

- RDP allowed only from designated Jump Hosts
- No direct internet access from servers
- Service accounts denied interactive logon
- Controlled patch windows
- Firewall rules aligned to Purdue model levels
- Strict logging for historian and jump systems

---

##  OT Security Objectives

| Objective | Objective | Objective |
|------------|------------|------------|
| Prevent lateral movement from IT to OT | Reduce ransomware blast radius | Maintain operational uptime |

---

##  Hardening Control Matrix

| Control | Risk Mitigated | Enforcement Method |
|----------|---------------|-------------------|
| Disable SMBv1 | Worm propagation | PowerShell + GPO |
| NTLMv2 Only | Credential downgrade attacks | Registry via GPO |
| RDP Restriction | Lateral movement | Security group policy |
| Advanced Audit Logging | Lack of visibility | Advanced Audit Policy |
| Disable Print Spooler | Remote exploit risk | Service control |
| Firewall Default Deny | Unauthorized access | Windows Firewall GPO |
