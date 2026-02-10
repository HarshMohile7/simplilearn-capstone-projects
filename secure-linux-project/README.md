# Secure File Storage and Access Management on Linux (Capstone)

## Project Overview
This project implements a secure file storage and access management system on Linux to prevent unauthorized access and to monitor file activities.  
Real-world use case: protecting confidential finance/HR/legal documents inside an organization.

## Problem Statement (Real-World Scenario)
A finance company faced an incident where confidential financial reports were accessed by an unauthorized user due to weak access controls and lack of monitoring.  
This project addresses that problem by enforcing strong access control and enabling auditing.

## Security Concepts Used
- **RBAC (Role-Based Access Control):** users are managed using Linux groups.
- **Linux Permissions (DAC):** owner/group/others permissions to control access.
- **Special Directory Bits**
  - **setgid:** new files inherit the project group automatically.
  - **sticky bit:** users cannot delete/rename other users’ files in the shared folder.
- **ACL (Access Control Lists):** fine-grained access rules beyond basic chmod.
- **Auditing (auditd):** logs read/write/execute/attribute changes inside the secure directory.
- **Automation:** scheduled extraction of audit logs to generate reports.
- **Reporting via Web (Apache2):** view audit report using a browser.

## Implementation Summary
1. Create shared group and users; add authorized users into the group (RBAC).
2. Create the secure project directory (example: `/home/project`).
3. Apply ownership and permissions with **setgid + sticky bit** (`chmod 3770`).
4. Apply ACL rules for controlled access (`setfacl`, `getfacl`).
5. Enable and configure `auditd` to monitor the directory (`auditctl`, `ausearch`).
6. Export audit logs into a readable report file.
7. (Optional) Host the report using Apache and automate updates using cron.

## Repository Contents
- `Secure_File_Storage_and_Access_Management_Capstone_Report.pdf` (full project report)
- (Optional) `evidence/` folder for outputs and screenshots

## How to Verify (Quick Proof)
- Directory permissions: `ls -ld /home/project`
- ACL rules: `getfacl /home/project`
- Audit logs: `sudo ausearch -k project_access`
- Web report (if enabled): `http://127.0.0.1/auditlog.txt`

## Author
Harsh Mohile
