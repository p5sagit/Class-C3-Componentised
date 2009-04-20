use strict;
use warnings;

use FindBin;
use Test::More;
use Test::Exception;

use lib "$FindBin::Bin/lib";


plan tests => 6;

use_ok('MyModule');

MyModule->load_components('Foo');

# Clear down inc so ppl dont mess us up with installing modules that we
# expect not to exist
#@INC = ();
# This breaks Carp1.08/perl 5.10.0; bah

throws_ok { MyModule->load_components('+ClassC3ComponentFooThatShouldntExist'); } qr/^Can't locate ClassC3ComponentFooThatShouldntExist.pm in \@INC/;

is(MyModule->new->message, "Foo MyModule", "it worked");

is(MyModule->load_optional_class('ClassC3ComponentFooThatShouldntExist'), 0, "load_optional_class NonexistantClass returned false");
is(MyModule->load_optional_class('MyModule::Plugin::Foo'), 1, "load_optional_class MyModule::Plugin::Foo (previously loaded module) returned true");
is(MyModule->load_optional_class('MyModule::OwnComponent'), 1, "load_optional_class MyModule::OwnComponent (not previously loaded module) returned true");

