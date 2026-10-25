# Project memory

## Reviewed baseline (2026-10-25)

- Podcaster skills, installation and media/export workflows. [README](README.md) describes usage and output contracts; use the affected skill's fixtures and export/import smoke checks for verification.
- Delivery base: `origin/main`, used to create `master`. Preserve existing skill invocation and output conventions.
- Current rollout is documentation-only; media pipelines and application tests have not been run.

## Handoff contract

Rollout verification: policy-coverage and local-link checks passed across all 13 workspace repositories; `git diff --check` passed. Application testing remains outside this documentation-only change.

After each item record task/owner, branch/worktree, base SHA, changed files, commit/PR, acceptance cases, exact verification commands/results/artifacts, pending external acceptance and next action. Store status in [project plan](PROJECT_PLAN.md); reconcile with Git and remote state on resume.
