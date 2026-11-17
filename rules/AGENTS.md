# AW Schedule Manager - P6 Guidelines (v1.9.0)

When interacting with Oracle Primavera P6 Professional via AW Schedule Manager:

## 1. Connection & Compatibility
- Always check the open project using `get_open_project` or run `check_compatibility` when starting a new session or working with a database for the first time.
- If no database is selected, run `choose_database`.
- Never attempt to write to the P6 SQLite database through direct scripts or raw SQL edits; use the AW Schedule Manager MCP tools exclusively.

## 2. Automatic Background Refresh & Scheduling (v1.9.0)
- **Automatic F5 & F9**: The plugin automatically closes open sub-windows inside P6 (WM_CLOSE), posts F5 (Refresh) and F9, and clicks the Schedule button in the background without moving the mouse or focusing the window (`AW_P6_AUTO_REFRESH=1`, `AW_P6_AUTO_SCHEDULE=1`).
- **User Notice Before Edits**: **BEFORE** the first edit of each chat message, inform the user in one clear line:
  > *ملاحظة: سيتم إغلاق أي نوافذ فرعية مفتوحة داخل Primavera تلقائياً عند انتهاء التعديل لتنفيذ التحديث وجدولة المشروع (F5/F9) في الخلفية.*
- **Post-Edit Reporting**: Check the `p6_auto_refresh` field in the tool result:
  - Report what was closed, refreshed, and scheduled.
  - Only ask the user to manually press **F5** or **F9** if `p6_auto_refresh` indicates it was skipped or failed.
- **Calibration Tool**: Use `calibrate_p6_refresh` if P6 was updated or if using a different UI language.

## 3. Backups (v1.9.0)
- One automatic backup is taken before the first edit of each chat message and covers subsequent edits within that message.
- For databases > 1 GB (`AW_P6_FULL_BACKUP_MAX_MB`), a fast **project backup** is taken (only tables with `proj_id` + shared tables) in ~1 second. Smaller databases receive a full compressed backup (`.db.gz`).
- Backups are stored in `p6_backups\<database_name>`.
- Never switch to an XER export as a substitute for backups.

## 4. Bulk Operations & Performance
- **Plan before editing**: Never perform edits one activity at a time. Read the necessary information first, then execute all changes in ONE tool call.
- Use `apply_changes` for mixed tool modifications in a single transaction (run `dry_run=true` first to get a `plan_id`, then execute with `dry_run=false`).
- Use `items` array parameter supported on editing tools to batch multiple modifications.
- Use wildcards (`*`, `?`) and status selectors (`not started`, `in progress`, `completed`, `started`, `open`) with `batch_update_activities`, `set_activity_fields`, `reset_progress`, etc.
- To split activities, use `split_in_progress` and verify with `check_split`.
