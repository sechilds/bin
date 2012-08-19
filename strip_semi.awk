#! /usr/bin/awk -f
BEGIN {
	regex_semi=";[ \t]*$";
	regex_semi_comment=";[ \t]*\/\/";
	regex_delimit_semi="#delimit ;";
	regex_delimit_cr="#delimit cr";
	semi_delimit = 0;
	changed_delimiter = 0
}
{
	if (match($0,regex_delimit_semi)) {
		semi_delimit = 1;
		changed_delimiter = 1;
	}
	if (match($0,regex_delimit_cr)) {
		semi_delimit = 0;
		changed_delimiter = 1;
	}
	if (changed_delimiter==0) {
		if (semi_delimit==1) {
			if (match($0,regex_semi) || match($0,regex_semi_comment)) {
				sub(/;/,"",$0);
				print $0
			} else {
				print $0 "\t///"
			}
		}
		else {
			print $0
		}
	}
	changed_delimiter = 0
}

