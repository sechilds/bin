#!/usr/bin/ruby
require 'time'
require 'erb'
require 'cgi'

filename = "~/.gitlogger"
## File format, One per line
# Repo Name:/path/to/base
dayone = true # log to day one? (true or false)
textlog = false # don't log to text file
# textlog = "~/Dropbox/Simplenote/GitLogger.md" # set to false to disable

git_user = %x{git config --get user.name}.strip
git_user = ENV['GIT_AUTHOR_NAME'] if git_user == ''
git_user = '.' if git_user == ''

entrytext = ""

File.open(File.expand_path(filename),'r') do |infile|
	while (line = infile.gets)
		name,path = line.strip.split(':')
		Dir.chdir(path)

		repo_log = ''
		repo_log = %x{git log --first-parent --no-merges --author="#{git_user}" --pretty=format:"* **[#{name}]** %%%ct%%: %s (%h)%n    %+b%n" --since="yesterday"}.gsub(/%(\d+)%/) { |timestamp|
			timestamp.gsub!(/%/,'')
			Time.at(timestamp.to_i).strftime("%I:%M %p").gsub(/^0/,'')
		}
		repo_log = %x{git fetch && git log --remotes --first-parent --no-merges --author="#{git_user}" --pretty=format:"* **[#{name}]** %%%ct%%: %s (%h)%n    %+b%n" --since="yesterday"}.gsub(/%(\d+)%/) { |timestamp|
			timestamp.gsub!(/%/,'')
			Time.at(timestamp.to_i).strftime("%I:%M %p").gsub(/^0/,'')
		} if repo_log == ''
		entrytext += repo_log
	end
end

exit if entrytext.strip == ""

entrytext += "\n"

if dayone
	uuid = %x{uuidgen}.gsub(/-/,'').strip
	datestamp = Time.now.utc.iso8601
	starred = false

	dayonedir = %x{ls ~/Library/Mobile\\ Documents/|grep dayoneapp}.strip
	dayonepath = "~/Library/Mobile\ Documents/#{dayonedir}/Documents/Journal_dayone/entries/"
	entry = CGI.escapeHTML("## Git Log #{Time.now.strftime("%F")}:\n\n#{entrytext.gsub(/^\s{4}\n/,"").gsub(/\n{3,}/m,"\n\n")}")
	template = ERB.new <<-XMLTEMPLATE
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Creation Date</key>
	<date><%= datestamp %></date>
	<key>Entry Text</key>
	<string><%= entry %></string>
	<key>Starred</key>
	<<%= starred %>/>
	<key>UUID</key>
	<string><%= uuid %></string>
</dict>
</plist>
XMLTEMPLATE

	fh = File.new(File.expand_path(dayonepath+uuid+".doentry"),'w+')
	fh.puts template.result(binding)
	fh.close
	# puts "ENTRY ADDED"
	# puts "------------------------"
	# puts "Time:    " + datestamp
	# puts "UUID:    " + uuid
	# puts "Starred: " + starred.to_s
	# puts "Entry:   " + entrytext
end
if textlog
	entry = "---\n\n### #{Time.now.strftime("%F")}:\n\n#{entrytext.gsub(/^\s{4}\n/,"").gsub(/\n{3,}/m,"\n\n")}"
	open(File.expand_path(textlog), 'a') { |f|
		f.puts entry
	}
end
