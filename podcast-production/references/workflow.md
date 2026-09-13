# Podcast Production Workflow Reference

Use this reference during the weekly UK–Taiwan film and entertainment workflow. Adapt commands to the tools installed on the machine; do not assume a particular transcription, noise-reduction, captioning, or publishing service is available.

## Episode brief

Use this compact brief before recording:

```text
episode: YYYY-MM-DD-slug
working_title:
angle:
audience:
opening_hook:
questions:
  -
  -
  -
sources:
  - title, publisher, date, URL
guest_names_and_terms_to_verify:
social_goal:
```

For current topics, prefer primary announcements, official festival or broadcaster pages, company statements, and reputable reporting. Separate verified facts from interpretation and label predictions as analysis.

## Suggested working layout

```text
episode-work/
  source/       # immutable original audio/video and speaker tracks
  working/      # transcript, proxy media, and rough-cut files
  exports/      # podcast and social review/final deliverables
  notes/        # episode brief, edit list, metadata, and QA notes
```

Repository-level generated deliverables belong in the ignored local folder:

```text
output/
  audio/       # podcast masters and listening copies
  captions/    # SRT, WebVTT, and caption backups
  reels/       # vertical MP4s and review renders
  final-cut/   # FCPXML, linked project media, and ZIP packages
  review/      # reviewer copies and visual checks
  notes/       # edit lists, metadata, QA, and reference breakdowns
```

Keep this output folder local. Track the recipe and project description, not rendered output media, unless the user explicitly requests versioning of a specific artifact.

## Tool roles

- `ffprobe`/`ffmpeg`: inspect media, extract audio, sync or trim, resize, encode, and mux captions.
- Speech-to-text: create a timestamped transcript for candidate discovery and captions.
- Audio editor or DSP tool: denoise, EQ, de-ess, compress, limit, and perform manual cleanup.
- Video editor or filter graph: reframe, add captions, and create reel or post assets.
- Podcast platform or publishing tool: upload or schedule only after the user confirms the final metadata and destination.

Keep lossless or high-bitrate working audio until the final delivery export.

## Validation checklist

Topic:

- Confirm the UK–Taiwan connection is clear, the angle is specific enough for one episode, and current claims have source links and dates.

Recording and rough cut:

- Confirm audio/video sync, speaker tracks, transcript timecodes, and that every cut is traceable.

Audio:

- Listen to the first, middle, and last minute, plus every edit boundary.
- Check clipped samples, clicks, pumping, excessive sibilance, missing words, and abrupt room-tone changes.
- Confirm both channels, sample rate, duration, and loudness are appropriate for the requested destination.

Reel or Instagram post:

- Watch once with sound and once muted.
- Verify captions against the transcript, especially proper nouns and technical terms.
- Confirm faces and captions are not cropped or covered, the first frame communicates the topic, and the final export plays from start to finish.
- Check music/effects do not compete with speech. For a static post, check legibility, quote accuracy, aspect ratio, episode reference, and CTA.

Do not call an episode or social asset final until the exported file has been checked, not merely the edit decision list or timeline.

## Candidate log format

```text
start: 00:12:34.500
end: 00:13:17.200
why: self-contained insight with a strong opening line
status: candidate | selected | rejected
notes: captions need the guest's surname checked
```
