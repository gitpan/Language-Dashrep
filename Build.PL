use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Language::Dashrep',
    license             => 'artistic',
    dist_author         => 'Richard Fobes <fobes@CPAN.org>',
    dist_version_from   => 'lib/Language/Dashrep.pm',
    build_requires => {
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'Language::Dashrep-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
