use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Class::C3::Componentised',
    dist_author         => 'Matt S. Trout <mst@shadowcatsystems.co.uk>',
    license             => 'perl',
    create_makefile_pl  => 'passthrough',
    dist_version_from   => 'lib/Class/C3/Componentised.pm',
    requires => {
        'Class::C3' => 0,
    },
    build_requires => {
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'Class-C3-Componentised-*' ],
);

$builder->create_build_script();
