#!perl
use strict;
use warnings;

use Cwd;
use File::Temp;
use Test::More tests => 5;

use_ok('App::CmdAll');

my $originalDir = cwd();

my $dir;
my $gitRepo = 'gitRepo';
my $svnRepo = 'svnRepo';

# Create and enter a temporary directory
sub setUp {
    # Cleanup any existing dir
    tearDown();

    # Create teh tempdir & go there
    $dir = File::Temp->newdir();
    chdir $dir;

    makeDir($gitRepo, '.git');
    makeDir($svnRepo, '.svn');
}

# Create a directory within the temp dir with the given directory within
# e.g. to make a fake git repo: makeDir('gitrepo', '.git')
#
# Returns the directory created
sub makeDir {
    my ($name, $contents) = @_;
    my $dirname = $dir . "/$name";

    mkdir $dirname;
    mkdir $dirname . "/$contents";

    return $dirname;
}

# Leave the tmpdir so that it can be cleaned up
sub tearDown {
    chdir $originalDir;
    undef $dir;
}

# Test git detection from command
setUp();
my $testFile = 'git_repo_file';
my @argv = ("touch $testFile");
my $cmdAll = App::CmdAll->new(\@argv, {'quiet' => 1});
$cmdAll->run();
ok(-f "$gitRepo/$testFile");
system("ls $svnRepo");
ok(! -f "$svnRepo/$testFile");

# Test svn detection from command
setUp();
$testFile = 'svn_repo_file';
@argv = ("touch $testFile");
$cmdAll = App::CmdAll->new(\@argv, {'quiet' => 1});
$cmdAll->run();
ok(-f "$svnRepo/$testFile");
ok(! -f "$gitRepo/$testFile");

#
# Tear down
#
tearDown();
