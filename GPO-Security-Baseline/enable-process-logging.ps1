New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System\Audit" `
-Name "ProcessCreationIncludeCmdLine_Enabled" -Value 1 -PropertyType DWORD -Force