# Final Cut Pro export

Import `槍擊埋下的23年真相-final-cut.fcpxml` with **File > Import > XML**.

This is a layered FCPXML 1.8 project for Final Cut Pro 10.8.1:

- `BG — UK Venue`: primary background with a slow scale keyframe.
- `FG — Title and Brand`: transparent foreground overlay on lane 3.
- `Avatar — Head 01–11`: independent avatar clips on lane 2. Each subtitle segment has its own head framing plus rotation keyframes, so the avatar changes at each subtitle beat.
- Caption lane: 11 editable ITT caption items attached to the background clip. Select a caption to change its text, duration, position, or style.
- Dialogue: the MP3 starts at source time 8.70s, matching the previously synced 29.76s highlight.

Keep the whole `media` folder beside the XML. If Final Cut reports offline media, relink the files inside `media/layers` and the dialogue MP3. The PNG layers are ready for FCP; the accompanying SVG files are editable source templates. `media/reference-style-captions.srt` remains as a backup/import alternative.

The older `media/sample-reference-style-reel.mp4` is a flattened reference render and is not used by this layered project.
