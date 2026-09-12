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

Use `scripts/inspect_media.sh` when inspecting local media. Read `references/workflow.md` when setting up an episode folder, preparing the topic brief, or validating exports.
