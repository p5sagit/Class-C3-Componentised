use strict;
use warnings;

use FindBin;
use Test::More;
use Test::Exception;

use lib "$FindBin::Bin/lib";


plan tests => 3;

use_ok('MyModule');

MyModule->load_components('Foo');

# Clear down inc so ppl dont mess us up with installing modules that we
# expect not to exist
@INC = ();

throws_ok { MyModule->load_components('+ClassC3ComponentFooThatShouldntExist'); } qr/^Can't locate ClassC3ComponentFooThatShouldntExist.pm in \@INC/;

is(MyModule->new->message, "Foo MyModule", "it worked");

