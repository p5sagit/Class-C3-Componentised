use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";

use Test::More;
use Test::Exception;

plan tests => 3;

use_ok('MyModule');

MyModule->load_components('Foo');

throws_ok { MyModule->load_components('+Foo'); } qr/^Can't locate Foo.pm in \@INC/;

is(MyModule->new->message, "Foo MyModule", "it worked");

