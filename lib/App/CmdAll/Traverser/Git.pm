package App::CmdAll::Traverser::Git;
use base 'App::CmdAll::Traverser::Base';
use strict;
use warnings;

# Return false if the passed directory does not have a .git subdirectory
sub test {
    my ($self, $dir) = @_;

    return (-d "$dir/.git");
}

1;
