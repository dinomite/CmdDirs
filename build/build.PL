#!/usr/bin/env perl
# Thanks to App::cpanminus
# See: https://github.com/miyagawa/cpanminus.git:script/build.PL
use English;

# build/cmdall.PL is the command-line framework (option parsing, etc.)
open my $in,  "<", "build/cmdall.PL" or die $!;
# The fatpacked binary we are building
open my $out, ">", "cmdall.tmp" or die $!;

print STDERR "Generating cmdall from script/cmdall.PL\n";

while (<$in>) {
    # Remove & replace things from bin/cmdall.PL
    next if /Auto-removed/;
    s/DEVELOPERS:.*/DO NOT EDIT -- this is an auto generated file/;
    s/.*__FATPACK__/`$EXECUTABLE_NAME -e "use App::FatPacker -run_script" file`/e;
    print $out $_;
}

close $out;

# Cleanup, make our fatpacked binary executable
unlink "cmdall";
rename "cmdall.tmp", "cmdall";
chmod 0755, "cmdall";

END { unlink "cmdall.tmp" }
