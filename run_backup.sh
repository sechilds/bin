#!/bin/bash
cp ~/Dropbox/Simplenote/drafts_clips.txt ~/.running/
cp ~/Dropbox/Simplenote/attacked.txt ~/.running/
cp ~/Dropbox/Simplenote/work.txt ~/.running/
cp ~/Dropbox/Simplenote/books.txt ~/.running/
cp ~/Dropbox/Simplenote/videos.txt ~/.running/

cd ~/.running
git add -v --ignore-errors .
git commit -qm "Backed up Running Files `date`"

