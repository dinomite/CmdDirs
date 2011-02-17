package Traverser::Git;
use strict;
use warnings;

use Traverser::Base;
our @ISA = ('Traverser::Base');

# Return false if the passed directory does not have a .git subdirectory
sub test {
    my ($self, $dir) = @_;

    return (-d "$dir/.git");
}

1;
