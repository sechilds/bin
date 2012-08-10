#Stephen's Scripts Directory#

Installed at `~/.bin`.
On my `$PATH`.
A collection of random scripts.

Scripts included:

* `gitlogger.rb` from [Brett Terpstra](http://brettterpstra.com).
(Please see [Scatterbrains: git as biographer](http://brettterpstra.com/scatterbrains-git-as-biographer/) and
[Git logger revisited](http://brettterpstra.com/git-logger-revisited/) for more information).
I've made a slight modification to put the date in YYYY-MM-DD format.
* `gitlogger_yesterday.rb` is a modification of the same script to log all git commits from the past day.
This is useful in case the program doesn't run the day before.
* `mailapp.py` is a program to send e-mails from the command line, but using all of Mail.app's settings.
It's taken directly from the post [Use Mail.app to send emails from the command line](http://nb.nathanamy.org/2012/04/send-emails-from-the-command-line/).
The code is available as a [gist](https://gist.github.com/2475544).
If you don't pass any text to it, it will wait for you to enter some.
To finish the command, press `CTRL-D`.
