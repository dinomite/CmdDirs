#!perl
use strict;
use warnings;

use Test::More qw(no_plan);

BEGIN {
    use_ok('App::CmdAll');
    use_ok('App::CmdAll::Traverser::Base');
    use_ok('App::CmdAll::Traverser::Git');
}

diag("Testing App-CmdAll $App::CmdAll::VERSION, Perl $], $^X");
