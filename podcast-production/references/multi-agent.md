# Multi-agent podcast production

Use this reference when more than one agent, developer, or tool is working on the same episode. The coordinator is the single decision owner; specialist agents produce evidence and artifacts that the coordinator can approve or reject.

## Suggested agent roster

Use only the roles needed for the requested deliverable. One agent may cover several roles when the task is small.

| Role | Reads | Owns | Completion criterion |
| --- | --- | --- | --- |
| Coordinator | request, manifest, all handoffs | episode manifest, decisions, final handoff | all required artifacts have an owner, status, and QA result |
| Topic researcher | brief, current sources | topic brief and source log | claims are separated from interpretation and sources include dates/URLs |
| Media inspector | source media | media report and technical warnings | duration, streams, sample rate, frame rate, channels, and sync risks are recorded |
| Audio editor | media report, transcript/markers | rough cut, audio master, edit decision list | every intentional cut has source timecode and audio QA is complete |
| Highlight editor | transcript, edit list | selected moment and caption timing | one self-contained highlight has source in/out and rationale |
| Reference analyst | supplied link/video/image | reference breakdown and layer/animation ledger | visual, caption, typography, timing, and motion decisions are recorded |
| Reel compositor | approved ledger, media | review MP4, captions, social copy | correct aspect ratio, readable captions, and synced audio pass review |
| FCP packager | approved ledger, media | FCPXML, linked media, README | XML validates and imports into target FCP without a crash |
| Publishing QA | final package | platform checklist and release note | metadata, links, format, playback, and approval state are recorded |

## Handoff contract

Every specialist handoff should be machine-readable enough for another agent to continue without rereading the whole conversation:

```text
episode: YYYY-MM-DD-slug
artifact: output/YYYY-MM-DD-slug/notes/selected-highlight-v001.yaml
owner: highlight-editor
status: ready | needs-review | blocked
inputs:
  - output/YYYY-MM-DD-slug/working/transcript.json
outputs:
  - output/YYYY-MM-DD-slug/notes/selected-highlight-v001.yaml
source_timecode: 00:12:34:12 -> 00:13:17:06
assumptions:
  - target frame rate is 30 fps
validation:
  - transcript names checked
next_owner: reference-analyst
open_questions:
  - confirm the guest's preferred spelling
```

The coordinator accepts a handoff only when the artifact exists, the completion criterion is met, and open questions are either resolved or explicitly passed to the next owner.

## Episode-scoped workspace

Prefer an episode-specific directory to prevent agents from overwriting each other:

```text
output/YYYY-MM-DD-slug/
  input/       # immutable source audio/video and supplied references
  working/     # proxies, transcript, markers, and intermediate data
  audio/       # masters and listening copies
  captions/    # SRT, WebVTT, and caption source of truth
  reels/       # review and final social renders
  final-cut/   # FCPXML, linked media, and package ZIP
  review/      # screenshots, review copies, and issue lists
  notes/       # manifest, ledgers, metadata, and QA reports
```

Keep reusable scripts and templates in the tracked skill. Keep episode media under ignored `output/`. Use stable artifact names with a version suffix (`v001`, `v002`) and create a new version after a substantive change; do not silently overwrite another agent's artifact.

## Parallelism and locking

- Parallelize source inspection, independent topic research, and reference analysis when they do not write the same artifact.
- Use a single caption/timing source of truth. The highlight editor approves timing; Reel and FCP agents consume it rather than redetecting speech independently.
- Serialize edits to the same media or manifest. Claim an artifact in the manifest before writing it, and release it with a handoff status.
- Run final media QA after the last render, not on an earlier draft.
- Keep publishing as a separate, approval-gated role. Preparing an upload package does not authorize publishing it.

## Failure and recovery

If an agent fails, keep its partial output in `working/` with `status: needs-review` or `blocked` and a short error note. The coordinator may reassign the artifact after checking its inputs. For FCPXML crashes, preserve the failing XML and crash signature, create a minimal reproducer, and let the FCP packager own the compatibility fix; downstream agents should continue from the approved ledger, not from a guessed rewrite.
