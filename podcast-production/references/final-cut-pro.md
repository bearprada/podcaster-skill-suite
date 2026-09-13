# Final Cut Pro editable reel reference

Read this reference when the deliverable must remain editable in Final Cut Pro, when a reference Reel must be decomposed into layers, or when an FCPXML import has failed.

## Reference-to-layer method

Capture the reference as a short design spec:

```text
reference:
source:
accessed:
format: 9:16 | 4:5 | square | other
duration:
style_summary:
caption_style:
typeface_and_weight:
motion_language:
audio_language:
copyright_or_attribution:
```

Then build a layer map. Keep each item independently replaceable where the user wants to fine-tune it:

| Layer | Purpose | Editable representation | Per-segment fields |
| --- | --- | --- | --- |
| BG | venue, texture, or primary footage | video/image clip | crop, fill, scale, pan, color |
| Dialogue | spoken highlight | audio clip | source in/out, gain, fades |
| Captions | readable transcript | FCP caption items or title clips | text, line break, in/out, position, style |
| Avatar | speaker/portrait presence | one connected clip per beat | source, crop, position, scale, rotation, opacity |
| FG | title, logo, border, decorative motion | transparent overlay clip(s) | text, font, color, opacity, keyframes |
| FX | optional accents | separate connected clips or effects | timing, blend, intensity |

Use a segment ledger before authoring the XML:

```text
segment: 01
source_in: 00:00:00:00
source_out: 00:00:01:18
caption: 劇情從二十三年前
caption_lines: 1
avatar_asset: avatar-head-01.png
avatar_position: 0 3
avatar_scale: 1.00
rotation: -4 -> 2
caption_style: bottom / centered / high contrast
transition: cut
```

Convert decimal seconds to the sequence frame rate before writing timeline offsets, durations, and keyframe times. This keeps the voice, caption, avatar swap, and motion beat aligned and prevents edit-boundary warnings.

## Crash-safe FCPXML shape

Known regression: Final Cut Pro 10.8.1 on Apple Silicon crashed with `EXC_CRASH (SIGABRT)` in `FFXMLImporter(AssetClipImport) addAssetClip` when the generated timeline used nested or connected `asset-clip` elements. Treat this as a conservative compatibility baseline; detect the installed target version and smoke-test that version before delivery. The stable shape used for the verified export is:

```xml
<spine>
  <clip name="BG" start="0s" duration="N/30s">
    <video ref="bg" start="0s" duration="N/30s"/>
    <clip lane="-1" offset="0s" duration="N/30s">
      <audio ref="dialogue" start="M/30s" duration="N/30s"/>
    </clip>
    <caption lane="1" offset="K/30s" duration="L/30s">...</caption>
    <clip lane="2" offset="K/30s" duration="L/30s">
      <video ref="avatar" start="0s" duration="L/30s"/>
    </clip>
    <clip lane="3" offset="0s" duration="N/30s">
      <video ref="foreground" start="0s" duration="N/30s"/>
    </clip>
  </clip>
</spine>
```

Use resource `<asset>` entries for linked media and explicit timeline `<video>`/`<audio>` elements. Keep captions as separate caption items when the user needs to adjust them. Give each avatar beat its own connected clip and its own rotation/scale keyframe animation. Use simple keyframes supported by the target FCP version; omit optional interpolation attributes when the importer warns that they are unsupported.

## Regression checklist

Run these checks before delivery:

1. `xmllint --noout <project>.fcpxml` succeeds.
2. The timeline contains no `asset-clip` elements for this FCP 10.8.1 compatibility path.
3. Timeline offsets, durations, and keyframe times are rational frame values such as `48/30s`; source-media resource duration may retain its measured decimal duration.
4. Caption count, avatar count, and layer names match the segment ledger.
5. If an SVG renderer produces opaque white around transparent artwork, render through a temporary green matte and chroma-key it to RGBA PNG; verify `file` reports RGBA and `sips -g hasAlpha` reports `yes`.
6. Open the XML in the user's installed Final Cut Pro. Confirm there is no warning dialog or crash and that all promised timeline items are visible and selectable.
7. Package the XML, media folder, README, SRT backup, and flattened MP4 fallback. Exclude temporary SVG render files unless the user explicitly wants them.
8. Record the FCP version, import result, warnings, crash signature if any, and commit hash in the handoff note.

If the smoke test crashes, do not keep iterating on the full project. Preserve the failing file, create a minimal project with one background and one connected layer, then add audio, captions, avatar clips, and foreground one at a time until the triggering structure is isolated.
