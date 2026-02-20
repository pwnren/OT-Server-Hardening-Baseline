## Create Dedicated OUs (Critical for Separation)
1. Open Group Policy Management (gpmc.msc)
2. Create OUs:
   - OU=OT-Servers
   - OU=Jump-Hosts
4. Move appropriate computer objects into correct OU

⚠ Never mix Jump Hosts and OT servers in same OU.
## Create Separate GPOs
Create these GPOs:
- GPO-OT-Server-Baseline
- GPO-Jump-Host-Baseline
- GPO-Domain-Security-Baseline

Link accordingly:
- Domain baseline → Domain root
- OT baseline → OT-Servers OU
- Jump baseline → Jump-Hosts OU

## DOMAIN-LEVEL SECURITY (Both OT + Jump)
Password Policy
Computer Configuration > Policies > Windows Settings > Security Settings > Account Policies > Password Policy
Set:
- Minimum password length: 10+
- Enforce password history: 24
- Maximum password age: 60–90 days (validate OT service accounts)

## NTLMv2 Enforcement
Computer Configuration > Windows Settings > Security Settings > Local Policies > Security Options
Setting:
Network security: LAN Manager authentication level
Set to:
Send NTLMv2 responses only. Refuse LM & NTLM
⚠ Validate legacy OT systems first.

## Disable SMBv1 (PowerShell Startup Script)
Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart
Add to:
Computer Configuration > Policies > Windows Settings > Scripts (Startup)

# JUMP HOST HARDENING
GPO Path:
Computer Configuration > Policies > Windows Settings > Security Settings > Local Policies > User Rights Assignment
Setting:
Allow log on through Remote Desktop Services
Add:
GG_JumpHost_RDP_Admins
Remove:
Domain Users

## Require Network Level Authentication (NLA)
Path:
Computer Configuration > Administrative Templates > Windows Components > Remote Desktop Services > Remote Desktop Session Host > Security
Enable:
Require user authentication for remote connections by using NLA

## Enable Remote Credential Guard
Path:
Computer Configuration > Administrative Templates > System > Credentials Delegation
Enable:
Restrict delegation of credentials to remote servers

## Disable LLMNR
Path:
Computer Configuration > Administrative Templates > Network > DNS Client
Set:
Turn off multicast name resolution = Enabled

## Disable NetBIOS (Powershell Startup Script)
wmic nicconfig where TcpipNetbiosOptions=0 call SetTcpipNetbios 2
Deploy via Startup Script GPO.

# OT SERVER HARDENING
## Prevent Forced Reboots
Path:
Computer Configuration > Administrative Templates > Windows Components > Windows Update
Enable:
No auto-restart with logged on users

# Restrict RDP to Jump Hosts Only
Windows Firewall GPO Path:
Computer Configuration > Windows Settings > Security Settings > Windows Defender Firewall > Inbound Rules

Create rule:
- Allow TCP 3389
- Source IP: Jump Host subnet only

# Deny Service Account Interactive Logon
Path: 
User Rights Assignment
Setting:
Deny log on locally
Deny log on through Remote Desktop Services
Add:
Service account groups

# Disable Print Spooler (If Not Needed)
Path:
Computer Configuration > Policies > Windows Settings > Security Settings > System Services
Set:
Print Spooler = Disabled

# AUDIT & LOGGING
Path:
Computer Configuration > Policies > Windows Settings > Security Settings > Advanced Audit Policy Configuration
Enable:
- Audit Logon
- Audit Privilege Use
- Audit Process Creation
- Audit Account Management

# Enable Process Creation Logging
Add registry:
New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System\Audit" `
-Name "ProcessCreationIncludeCmdLine_Enabled" -Value 1 -PropertyType DWORD -Force
Deploy via GPO Preference.

# Security Log Size (Compliance Retention)
Path:
Security Options > Security: Specify the maximum log file size (KB)

# FIREWALL BASELINE (Both)
Default Deny Inbound
Path:
Windows Defender Firewall > Properties
Set:
- Inbound: Block (default)
- Outbound: Allow (controlled per role)

# Restrict Management Ports
Create inbound rules for:
- RDP (3389)
- WinRM (5985/5986)
- SMB (445)

Allow only:
- Jump Host subnet
- Domain Controllers (if required)

# LAPS Implementation
1. Install LAPS AD schema extension
2. Deploy LAPS via GPO: Computer Configuration > Administrative Templates > LAPS
3. Enable password backup to AD

# Validation 
gpresult /h report.html
Verify:
- Correct GPO applied
- NTLM policy enforced
- Firewall rules present
- Audit policies active

⚠ OT Safety Reminders
Before applying to production:
- Validate vendor compatibility
- Test in lab
- Confirm service account impact
- Validate RDP tool compatibility
- Confirm no dependency on NetBIOS
