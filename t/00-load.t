#!perl
use strict;
use warnings;

use Test::More tests => 4;

BEGIN {
    use_ok('App::CmdAll');
    use_ok('App::CmdAll::Traverser::Base');
    use_ok('App::CmdAll::Traverser::Git');
    use_ok('App::CmdAll::Traverser::Subversion');
}

diag("Testing App-CmdAll $App::CmdAll::VERSION, Perl $], $^X");
