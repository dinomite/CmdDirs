#!perl
use strict;
use warnings;

use File::Temp;
use Test::More tests => 3;

use App::CmdAll;

my $dir;

sub setUp {
    $dir = File::Temp->newdir();
}

sub tearDown {
    undef $dir;
}

my $cmdAll = App::CmdAll->new(\@ARGV, $options);
