use 5.12.0;
use warnings;

use lib 't/lib';
#use Devel::Cover qw(-silent 1);

use App::CmdAllTest;

Test::Class->runtests();
