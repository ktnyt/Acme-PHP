use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Acme::PHP',
    license             => 'artistic2',
    dist_author         => 'Kotone Itaya <t11080hi [at] sfc.keio.ac.jp>',
    dist_version_from   => 'lib/Acme/PHP.pm',
    requires => {
        'Test::More' => 0,
        'version'    => 0,
    },
    add_to_cleanup      => [ 'Acme-PHP-*' ],
);

$builder->create_build_script();
