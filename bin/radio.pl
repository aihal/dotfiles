#!/usr/bin/perl
# radio.pl
# give "list" or a stationname as cli argument
# without argument enter interactive inputting a stationname
use strict;
use warnings;

my %stations = (
'barcelonajazz' => 'http://www.live365.com/play/jmestres',
'dradio' => 'http://dradio.ic.llnwd.net/stream/dradio_dlf_m_a.ogg',
'bbcworld' => 'mms://a973.l3944038972.c39440.g.lm.akamaistream.net/D/973/39440/v0001/reflector:38972',
'radiopego' => 'http://www.radiopego.com:8000',
'jazz24' => 'http://sc1.abacast.com:8236/',
'smoothjazz' => 'http://scfire-ntc-aa07.stream.aol.com/stream/1010/'
);
my @stationnames = keys %stations;
my $mplayeroptions = "-input file=/home/ogion/.mplayer/pipe -msgcolor -msgmodule";
#my @links = values %stations; # not needed yet but might be useful
my $cliarg;
if ( defined $ARGV[0] ) {
	my $cliarg = $ARGV[0];
	if ( $cliarg eq "list" ) {
		print "@stationnames\n";
		exit 0;
	}
	if ( grep { $_ eq $cliarg } @stationnames ) {
		system("/usr/bin/mplayer $mplayeroptions $stations{$cliarg}");
	} else	{
		print "Please provide a valid radio station name commandline argument. (use \"list\" as argument to see a list of names)\n"; 
		exit 1;
	}
} else {
	my $selection;
	print "Enter the name of the radio station.", "\n";
	$selection = <STDIN>;
	chomp($selection);
	if ( grep { $_ eq $selection } @stationnames ) {
		system("/usr/bin/mplayer $mplayeroptions $stations{$selection}");
	} else	{
		print "Please provide a valid radio station name. (use \"list\" as argument to see a list of names)\n"; 
		exit 1;
	}
}
