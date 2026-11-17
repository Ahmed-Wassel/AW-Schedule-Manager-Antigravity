# AW Schedule Manager - Google Antigravity Plugin

Connect **Google Antigravity** to your **Oracle Primavera P6 Professional** SQLite database. Ask about your schedules in plain language, edit activities and relationships, load resources and costs, perform DCMA 14-point quality audits, or build and export schedules as XER files directly within Antigravity.

> **Note**: This is an independent project. It is not made, endorsed, or supported by Oracle or Google. Primavera and P6 are registered trademarks of Oracle and/or its affiliates.

---

## Features

- **Ready to Use (No Python Required)**: Fully compiled standalone server. No need to install Python, packages, or build tools.
- **Automatic Background Scheduling (F5 & F9)**: Automatically refreshes and runs schedule calculation (F9) in the background without moving your mouse.
- **Automated Backups**: Safety first — automatic compressed backups before any database modification.
- **Full Schedule Management**:
  - DCMA 14-Point Assessment (`dcma_check`)
  - Critical Path Analysis (`critical_path`)
  - S-Curves and Cash Flow (`cash_flow`)
  - Baseline Variance & Delay Windows (`baseline_variance`, `delay_windows`)
  - Batch Updates & Progress Imports (`batch_update_activities`, `import_progress_from_excel`)
  - XER Generation & Export (`export_schedule_xer`)

---

## Installation in Google Antigravity

### Method 1: Automatic 1-Click Installer (Recommended)
1. Download or clone this repository to your computer.
2. Double-click `install.bat` (or run `./install.ps1` in PowerShell).
3. The script automatically installs the plugin into `%USERPROFILE%\.gemini\config\plugins\aw-schedule-manager` and configures the paths.
4. Restart Google Antigravity.

---

### Method 2: Manual Global Installation
1. Copy the entire `aw-schedule-manager` folder to your global Antigravity plugins directory:
   ```text
   C:\Users\<Your-Username>\.gemini\config\plugins\aw-schedule-manager
   ```
2. In `mcp_config.json`, ensure the `command` points to the `server/aw-schedule-manager.exe` binary.
3. Open Antigravity; the plugin will be detected automatically across all your workspaces.

---

### Method 3: Workspace / Project Scope
If you want to use the plugin only inside a specific repository/project:
1. Place this folder inside your workspace root under:
   ```text
   .agents/plugins/aw-schedule-manager/
   ```
2. When you open that project workspace in Antigravity, the plugin will load automatically for that project.

---

## Getting Started

1. Open your project in Google Antigravity.
2. Select your Primavera P6 SQLite database:
   - Ask Antigravity: `Run choose_database` to open a file picker and select your database file (`.db`).
   - Or run `check_compatibility` to verify connection with your P6 database.
3. Start chatting with your schedule!

### Example Prompts

- *"لخص لي المشروع المفتوح في بريمافيرا واعرض الأنشطة الحرجة (Critical Path)."*
- *"Run a DCMA 14-point schedule assessment on the current project."*
- *"قارن بين البايسلاين والتحديث الحالي واعرض الأنشطة التي تأخرت أكثر من 5 أيام."*
- *"Add a 10-day activity 'Site Mobilization' under WBS 1.1 and link it to activity A1010."*
- *"Export the current project schedule to an XER file."*

---

## Safety & Backups

- **Automated Backups**: Backups are saved in `p6_backups\<database_name>` alongside your `.db` file before any write operation.
- **Read-Only Mode**: You can set `"CLAUDE_PLUGIN_OPTION_READ_ONLY": "true"` in `mcp_config.json` to disable all editing tools and restrict Antigravity to read-only queries.

---

## License

Copyright (c) 2026 Ahmed Wassel. All rights reserved.  
AW Schedule Manager is proprietary software, free to use under the [License Agreement](LICENSE): install and use it unmodified for your own work, including commercial work. Redistributing, changing, or reverse engineering is not permitted.
