#!/usr/bin/perl
use LWP::UserAgent;
use HTTP::Request;
use Mozilla::CA;
## Assemble the URL to submit to Instapaper
my $username=`security find-internet-password -s instapaper.com | grep "acct" | cut -d '"' -f 4`;
my $password=`security 2>&1 >/dev/null find-internet-password -gs instapaper.com | cut -d '"' -f 2`;
my $instapaper_api = 'https://www.instapaper.com/api/add';
my $username = chomp($username);
my $password = chomp($password);

my $URL = $instapaper_api."?username=".$username."&password=".$password."&url=".$ARGV[0];
my $agent = LWP::UserAgent->new(env_proxy=>1, keep_alive=>1, timeout=>30);
my $request = HTTP::Request->new(GET=>$URL);
my $response = $agent->request($request);
print $response->as_string . "\n";


