use strict;
use warnings;

use FindBin;
use Test::More;

use lib "$FindBin::Bin/lib";

my $awesome_robot = 0;
my $first = 0;
my $last = 0;

BEGIN {
  package MyModule::Plugin::TestActions;

  use Class::C3::Componentised::LoadActions;

  BEFORE_APPLY sub { $awesome_robot++; $first = $awesome_robot };
  AFTER_APPLY  sub { $awesome_robot++;  $last  = $awesome_robot };

  1;
}

use_ok('MyModule');
is $first, 0, 'first starts at zero';
is $last, 0, 'last starts at zero';

MyModule->load_components('TestActions');
is $first, 1, 'first gets value of 1 (it runs first)';
is $last, 2, 'last gets value of 2 (it runs last)';

done_testing;
