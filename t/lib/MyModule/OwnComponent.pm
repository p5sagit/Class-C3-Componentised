package # hide from pause
  MyModule::OwnComponent;

use MRO::Compat;
use mro 'c3';

sub message {
  my $self = shift;

  return join(" ", "OwnComponent", $self->next::method);
}

1;
