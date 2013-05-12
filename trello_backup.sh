#!/bin/bash
cd ~/.trello
/usr/bin/php /Users/sechilds/dev/trello-backup/trello-backup.php
git add -v --ignore-errors .
git commit -qm "Backed up Trello Boards `date`"

