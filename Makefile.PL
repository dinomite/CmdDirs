=for developers

If you're a developer, Makefile.PL will pack `cmdall` from
build/cmdall.PL and then copy that file to `bin/cmdall`.

You can pretend to be an author by running it with:

  perl Makefile.PL --author

You should install App::FatPacker before doing so.

Do not commit the changes to the `cmdall` standalone executable. We only
commit changes to this file whenever we tag a new CPAN release.

=cut
use English '-no_match_vars';

my $author = ((grep{ $_ eq '--author' } @ARGV) or -d '.git' && `git remote -v` =~ /git\@github/);
print STDERR "Running in author mode!\n" if $author;

# Author: perl Makefile.PL packs 'build/cmdall.PL' -> 'cmdall'
if ($author) {
    shift @ARGV;
    system $EXECUTABLE_NAME, "build/build.PL" and die $?;
}

# perl Makefile.PL (from git repo) copies 'cmdall' -> 'bin/cmdall'
if (-e 'cmdall') {
    print STDERR "Generating bin/cmdall from cmdall\n";
    mkdir 'bin';
    open my $in,  "<cmdall"     or die $!;
    open my $out, ">bin/cmdall" or die $!;
    while (<$in>) {
        s|^#!/usr/bin/env perl|#!perl|; # so MakeMaker can fix it
        print $out $_
    }
}

use ExtUtils::MakeMaker;
WriteMakefile(
    NAME => 'App::CmdAll',
    VERSION_FROM => "lib/App/CmdAll.pm",
    ABSTRACT => 'Perform a command in subdirectories',
    PREREQ_PM => {
        'Module::Build' => 0.36,
        'ExtUtils::MakeMaker' => 6.31,
        'ExtUtils::Install' => 1.46,
    },
    LICENSE => 'perl',
    EXE_FILES => [ 'bin/cmdall' ],
);
