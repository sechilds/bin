#! /usr/bin/awk -f
BEGIN {
	regex_semi=";[ \t]*$"
	regex_semi_comment=";[ \t]*\/\/[\w\s\d]*$"
}
{
	if (match($0,regex_semi) || match($0,regex_semi_comment)) {
		print $0
	}
}

