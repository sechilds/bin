#! /usr/bin/awk -f
BEGIN {
	regex_semi=";[ \t\*]*[\/\/]?[ \t]*$"
}
{
	if (match($0,regex_semi)) {
		print $0
	}
}

