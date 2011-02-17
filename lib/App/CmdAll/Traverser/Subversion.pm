package App::CmdAll::Traverser::Subversion;
use strict;
use warnings;

use App::CmdAll::Traverser::Base;
our @ISA = ('App::CmdAll::Traverser::Base');

# Return false if the passed directory does not have a .svn subdirectory
sub test {
    my ($self, $dir) = @_;

    return (-d "$dir/.svn");
}

1;
