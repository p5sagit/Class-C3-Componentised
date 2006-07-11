package Class::C3::Componentised;

use strict;
use warnings;

use vars qw($VERSION);

use Class::C3;

$VERSION = "0.01";

sub inject_base {
  my ($class, $target, @to_inject) = @_;
  {
    no strict 'refs';
    my %seen;
    unshift( @{"${target}::ISA"},
        grep { !$seen{ $_ }++ && $target ne $_ && !$target->isa($_) }
            @to_inject
    );
  }

  # Yes, this is hack. But it *does* work. Please don't submit tickets about
  # it on the basis of the comments in Class::C3, the author was on #dbix-class
  # while I was implementing this.

  my $table = { Class::C3::_dump_MRO_table };
  eval "package $target; import Class::C3;" unless exists $table->{$target};
}

sub load_components {
  my $class = shift;
  my $base = $class->component_base_class;
  my @comp = map { /^\+(.*)$/ ? $1 : "${base}::$_" } grep { $_ !~ /^#/ } @_;
  $class->_load_components(@comp);
  Class::C3::reinitialize();
}

sub load_own_components {
  my $class = shift;
  my @comp = map { "${class}::$_" } grep { $_ !~ /^#/ } @_;
  $class->_load_components(@comp);
}

sub _load_components {
  my ($class, @comp) = @_;
  foreach my $comp (@comp) {
    eval "use $comp";
    die $@ if $@;
  }
  $class->inject_base($class => @comp);
}

1;

__END__

=head1 NAME

Class::C3::Componentised - extend and mix classes at runtime

=head1 SYNOPSIS

    package MyApp;

    use base "Class::C3::Componentised";

    sub component_base_class { "MyApp" };
    

    package main;

    MyApp->load_components(qw/Foo Bar Baz/);

=head1 DESCRIPTION

=head2 inject_base

=head2 load_components

=head2 load_own_components

=head1 AUTHOR

Matt S. Trout <mst@shadowcatsystems.co.uk>

=head1 LICENSE

You may distribute this code under the same terms as Perl itself.
