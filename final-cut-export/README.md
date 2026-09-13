# Final Cut Pro export

Import `槍擊埋下的23年真相-final-cut.fcpxml` with **File > Import > XML** in Final Cut Pro 10.8.1 or later.

## Why this version should not crash

Final Cut Pro 10.8.1 was crashing in its XML importer while processing nested `asset-clip` elements. This export uses one primary `clip` with explicit `video`, `audio`, caption, and connected `clip` elements instead. The timeline media is aligned to the 30 fps project frame grid.

## Editable timeline layers

- `BG — UK Venue`: primary background, with a slow scale animation.
- `Caption 01–11`: independent ITT captions on lane 1. Edit text, timing, placement, and style in Final Cut Pro.
- `Avatar — Head 01–11`: separate portrait clips on lane 2. Each matches one caption beat and has independent rotation keyframes.
- `FG — Title and Brand`: transparent title/brand overlay on lane 3.
- `Dialogue — 槍擊埋下的23年真相`: dialogue MP3 on its own audio lane; it starts at source time 8.70 seconds.

The PNG layers contain real alpha transparency. The accompanying SVG templates can be regenerated with `create_editable_fcp_layers.sh`; SVG source files are excluded from the ZIP because FCP uses the PNG layers.

Keep the whole `media` folder beside the XML. If Final Cut reports offline media, relink the files in `media/layers` and the dialogue MP3.

`media/reference-style-captions.srt` is a backup caption file. The older `media/sample-reference-style-reel.mp4` is a flattened reference render and is not used by the editable project.
