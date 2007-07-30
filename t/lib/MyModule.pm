package # hide from pause
  MyModule;

use base 'Class::C3::Componentised';

sub component_base_class { "MyModule::Plugin" }

sub message { "MyModule" }

sub new { 
  return bless {}, shift;
}

1;
