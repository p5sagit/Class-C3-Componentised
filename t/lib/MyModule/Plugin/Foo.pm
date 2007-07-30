package # hide from pause
  MyModule::Plugin::Foo;

use Class::C3;

sub message { 
  $DB::single = 1;
  join(" ", "Foo", shift->next::method) 
}

1;
