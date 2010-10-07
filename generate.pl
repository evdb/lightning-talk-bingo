#!/usr/bin/env perl

use strict;
use warnings;

use File::Slurp;
use List::Util qw(shuffle);
use Template;

my @all_events =    #
  sort              #
  grep { $_ }       #
  map { chomp; $_; }    #
  read_file('events.txt');

sub random_events {
    my $number = shift || 16;
    my @events = shuffle @all_events;
    @events = @events[ 0 .. $number - 1 ];
    return @events;
}

# some useful options (see below for full list)
# create Template object
my $template = Template->new();

my $vars          = { random_events => \&random_events, };
my $template_file = "template.html";
my $output        = '';

# process input template, substituting variables
$template->process( $template_file, $vars, \$output )
  || die $template->error();

print $output;
