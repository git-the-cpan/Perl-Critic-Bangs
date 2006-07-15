use strict;
use warnings;
use ExtUtils::MakeMaker;


my @files = glob( "*.pm" );

my %filemap;
my %podmap;
for my $file ( @files ) {
    if ( $file eq "Bangs.pm" ) {
        $filemap{$file} = '$(INST_LIBDIR)/Bangs.pm';
        $podmap{$file}  = '$(INST_PODDIR)/Perl::Critic::Bangs.3pm';
    }
    else {
        $filemap{$file} = "\$(INST_LIBDIR)/Policy/Bangs/$file";

        my $podname = $file;
        $podname =~ s/\.pm$/.3pm/;
        $podmap{$file}  = "\$(INST_MAN3DIR)/Perl::Critic::Policy::Bangs::$podname";
    }
}

WriteMakefile(
    NAME                => 'Perl::Critic::Bangs',
    AUTHOR              => 'Andy Lester <andy@petdance.com>',
    VERSION_FROM        => 'Bangs.pm',
    ABSTRACT            => 'Perl::Critic::Bangs - A collection of policies for Perl::Critic',
    PL_FILES            => {},
    PM                  => \%filemap,
    MAN3PODS            => \%podmap, # Overriding this seems to do no good
    PREREQ_PM => {
        'Perl::Critic' => 0,
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Perl-Critic-Bangs-*' },
);

print <<'EOF';

NOTE: The man pages are not built correctly yet.  I don't
know why, and am working with Schwern on it.
EOF
