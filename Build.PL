use 5.006;
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Log::Log4perl::Appender::Wx',
    license             => 'perl',
    dist_author         => q{Tarek Unger <tu2@gmx.net>},
    dist_version_from   => 'lib/Log/Log4perl/Appender/Wx.pm',
    build_requires => {
        'Test::More' => 0,
    },
    requires => {
        'perl' => 5.006,
    },
    add_to_cleanup      => [ 'Log-Log4perl-Appender-Wx-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
