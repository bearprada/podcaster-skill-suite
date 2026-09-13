---
name: podcast-production
description: "Run a weekly UK–Taiwan film and entertainment podcast workflow: develop timely topics, rough-cut 2–3 hour audio/video recordings, prepare podcast publishing assets, and create a highlight reel or Instagram post."
---

# Podcast Production

Use this skill for a recurring podcast about the UK and Taiwan movie or entertainment industries. The normal run starts with topic development and ends with a publish-ready podcast package plus one social highlight. Preserve an untouched original recording. If the user asks for only one stage, perform only that stage unless another is required for the requested deliverable.

## Weekly workflow

### 1. Develop the topic

Create 3–5 timely topic options around UK–Taiwan film and entertainment. When an idea depends on current events, use current, high-trust sources and record source links and dates. Useful angles include film and TV, streaming, festivals, co-productions, distribution, talent, cultural exchange, policy, and audience trends.

For each option, provide a working title, the UK–Taiwan connection, why it matters now, three discussion questions or contrasting viewpoints, a possible opening hook, and facts that need verification. Recommend one topic, but treat the angle as approved only after the user chooses or confirms it.

Completion criterion: an approved episode brief exists with the angle, questions, hook, audience, and sources.

### 2. Record the episode

Prepare a compact run-of-show from the approved brief: opening, segment order, transitions, names and terms to verify, and closing call to action. The recording may be 2–3 hours and include video. Encourage separate local audio tracks for each speaker when available, stable camera framing, and a sync reference at the start.

Completion criterion: original audio/video files, separate speaker tracks if available, and the episode brief are stored together with clear filenames.

### 3. Rough-cut the recording

Inspect the source before editing. For a long recording, transcribe or create timecoded markers, then remove technical failures, duplicated takes, extended dead air, and clearly abandoned sections. Keep the original meaning and conversational flow; reserve detailed mixing for the final audio pass.

Create an edit decision list with kept sections, cuts, unresolved questions, and promising highlight timecodes.

Completion criterion: a reviewable rough cut exists and every intentional cut is traceable to a source timecode.

### 4. Prepare and publish the podcast

Post-process the approved rough cut in a speech-first order: correct speaker balance, remove only problematic noise, use gentle EQ/de-essing/compression, then limit and check the result. Create the publishing package: final audio, episode title, description, show notes, chapters or time markers when supported, guest credits, source credits, and artwork if needed.

Check the final file for clicks, clipping, missing words, abrupt room-tone changes, channel problems, and intelligibility. Use a loudness-based target when the destination or user specifies one. Prepare the upload or scheduling form, but require confirmation of the exact platform, metadata, and publish time immediately before an external publish action.

Completion criterion: the final audio and complete metadata package pass QA, and publication is either confirmed or explicitly left ready for the user.

### 5. Create the social highlight

Choose the strongest self-contained moment from the edit decision list or transcript: a sharp opinion, useful insight, emotional turn, surprising statement, or story with a clear hook. Prefer one primary moment and retain its source and final timecodes.

Default to a 30–60 second vertical reel when video is usable. Reframe to 9:16, keep the speaker visible, add accurate burned-in captions, and use a speech-first mix. If the video is unusable or a static post is more suitable, create an Instagram post instead: a concise quote or claim, short context, episode reference, and clear call to action in a 4:5 or square layout.

Manually verify names, film titles, subtitles, jargon, caption line breaks, faces, safe margins, and the first seconds without sound.

Completion criterion: one reviewable reel or Instagram post is exported with its caption/copy, source timecode, episode-link placeholder, and unresolved issues listed.

### 6. Rebuild a reel from a reference

When the user provides an Instagram post, video, screenshot, or other reference, inspect it if accessible and turn the reference into a production brief rather than copying it blindly. Record the reference URL or file, access date, aspect ratio, duration, visual rhythm, typography, caption treatment, audio treatment, and any copyright or attribution concern.

Break the target into an explicit layer map before editing:

- background or primary footage
- foreground title, logo, frame, gradient, and decorative effects
- speaker, avatar, or portrait layer
- caption/text layer
- audio, music, and sound effects

For each highlight segment, record start/end time, spoken text, caption text and line breaks, active assets, position, scale, rotation, opacity, transition, and the animation curve or keyframe intent. Use this map to keep speech, captions, avatar changes, and motion on the same frame grid. If a reference is inaccessible, state that it is a visual inference and ask for a screenshot or downloaded sample only when the missing detail changes the design.

Completion criterion: a reference breakdown and a segment-by-segment layer/animation plan exist before the final render or editable project is built.

### 7. Export an editable Final Cut Pro project

When the user requests Final Cut Pro or editable layers, preserve separate layers and captions in FCPXML, plus a reviewable flattened MP4 fallback. Read [references/final-cut-pro.md](references/final-cut-pro.md) for the compatibility and validation rules. Use a project-specific media folder and a README that names every layer and its source.

Import the generated XML into the installed Final Cut Pro version as a real smoke test. Check the import dialog for warnings, confirm the project opens, and verify that the timeline exposes the background, caption lane, avatar clips, foreground, and dialogue audio as separate items. If import fails or FCP crashes, keep the original XML, capture the error or crash signature, reduce the structure to a minimal reproducer, and revise the exporter before delivering another XML.

Completion criterion: the editable XML passes XML validation, imports into the user's installed FCP without a crash, exposes the promised editable layers, and is packaged with media, README, fallback render, and a recorded validation result.

## Source inspection and audio rules

Before editing, identify input files, duration, channels, sample rate, video presence, and available tools. Ask only for choices that materially affect output: target platform/aspect ratio, desired length, brand assets, and exact loudness target.

Apply audio processing in an order that keeps speech natural:

1. Check clipping, hum, broadband noise, room tone, plosives, sibilance, and uneven speaker levels.
2. Remove only problematic noise and retain enough room tone to keep edits natural.
3. Edit long silences, false starts, repeated phrases, or obvious mouth noise only when the edit is unambiguous.
4. Match speakers, then apply gentle corrective EQ, de-essing, compression, and limiting.
5. Check mono compatibility, intelligibility, peaks, and the beginning and end for clicks or abrupt cuts.
6. Export a high-quality master plus the requested delivery format, with processing choices and a short QA note.

Keep the original media. Do not invent missing words, aggressively denoise music or ambience, or normalize by peak alone when a loudness-based delivery is requested. If the source is clipped or severely damaged, state what can and cannot be recovered.

## Default deliverables

- Topic brief: one approved angle, questions, hook, audience, and verified sources.
- Rough cut: reviewable long-form edit plus edit decision list.
- Podcast package: clean spoken-word master, compressed listening copy, metadata, show notes, and QA note.
- Social package: a 30–60 second 9:16 captioned H.264/AAC MP4, or a 4:5/square Instagram post with copy and CTA.
- Reference breakdown: reference metadata, layer map, animation notes, typography/caption notes, and segment timing plan.
- Editable project: FCPXML, linked media folder, editable captions and layers, flattened fallback render, README, and import-validation note.

Use `scripts/inspect_media.sh` when inspecting local media. Read `references/workflow.md` when setting up an episode folder, preparing the topic brief, or validating exports. Read `references/final-cut-pro.md` when the user requests an editable Final Cut project, supplies a visual reference for a layered reel, or reports an FCPXML import error/crash.

## Output storage

Store generated deliverables in the local, Git-ignored `output/` folder. Organize them as `output/audio/`, `output/captions/`, `output/reels/`, `output/final-cut/`, `output/review/`, and `output/notes/`. Keep original media, reusable scripts, skill instructions, project manifests, and reproducible recipes tracked; keep rendered media, exports, temporary conversions, and platform upload packages local unless the user explicitly asks to commit or upload them.

At handoff, report the output paths and validation status. Do not stage or commit anything under `output/` as part of the normal workflow.
