use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Perl::Critic::Bangs',
    AUTHOR              => 'Andy Lester <andy@petdance.com>',
    VERSION_FROM        => 'lib/Perl/Critic/Bangs.pm',
    ABSTRACT            => 'Perl::Critic::Bangs - A collection of policies for Perl::Critic',
    PL_FILES            => {},
    PREREQ_PM => {
        'Perl::Critic' => 0,
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Perl-Critic-Bangs-*' },
);
