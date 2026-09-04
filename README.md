# TheLook Marketing Spoke Project

This is a dedicated **Departmental Spoke** Looker project for the Marketing Department, built on top of the Central Governed Hub (`thelook-antigravity`).

## Architecture
- **Imports**: `thelook-antigravity` via Looker Project Import (`manifest.lkml`).
- **Refinements**: `views/users_rfn.view.lkml` refines `+users` with channel groupings and acquisition metrics.
- **Extensions**: `views/users_ext.view.lkml` creates `users_ext` for cohort analysis.
- **Model**: `models/thelook_marketing.model.lkml` exposes marketing-labeled explores with marketing caching rules.
