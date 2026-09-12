# Final Cut Pro export

Import `槍擊埋下的23年真相-final-cut.fcpxml` in Final Cut Pro with **File > Import > XML**.

This is a conservative FCPXML 1.8 import containing one direct timeline clip. It avoids nested `asset-clip` and caption structures that can crash the Final Cut Pro 10.8.1 XML importer.

Keep the `media` folder beside the XML. If Final Cut reports offline media, relink the clip to `media/sample-reference-style-reel.mp4`.

Import `media/reference-style-captions.srt` separately if you want an editable caption track. The MP4 itself contains the reference graphics, so disable its imported captions if you use the SRT track.

The source portrait and original MP3 remain in the `media` folder for manual replacement and animation work in Final Cut Pro or Motion.
