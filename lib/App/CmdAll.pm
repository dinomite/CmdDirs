package App::CmdAll;
use strict;
use warnings;

use Cwd;
use Getopt::Long;

use App::CmdAll::Traverser::Base;

our $VERSION;
BEGIN {
    $VERSION = '1.00';
}

sub new {
    my ($class, $argv, $options) = @_;

    my $self = {};
    $self->{'argv'} = $argv;
    $self->{'options'} = $options;
    bless $self, $class;

    return $self;
}

sub run {
    my ($self) = @_;

    # Pull working dir & post-option arguments
    my $topDir = cwd();
    my $command = $ARGV[0];
    my @dirs;

    # Get any dirs passed on the command line
    foreach (my $x = 1; $x <= $#ARGV; $x++) {
        push @dirs, $ARGV[$x];
    }

    # No directories passed, glob all
    if ($#dirs == -1) {
        @dirs = glob '*';
    }

    my $traverser;
    # Create a traverser for specific command types
    # TODO use command line switches (--git) also
    # TODO resepect $allDirs
    if ($command =~ /git/) {
        require App::CmdAll::Traverser::Git;
        $traverser = App::CmdAll::Traverser::Git->new($command, $topDir, \@dirs);
    } else {
        $traverser = App::CmdAll::Traverser::Base->new($command, $topDir, \@dirs);
    }

    $traverser->traverse($self->{'options'}->{'quiet'});
}

1;
