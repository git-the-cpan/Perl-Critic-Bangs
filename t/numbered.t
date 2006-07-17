use strict;
use warnings;
use Test::More tests => 2;
use Perl::Critic::Config;
use Perl::Critic;

BEGIN {
    use_ok( 'Perl::Critic::Policy::Bangs::ProhibitNumberedNames' );
}

# common P::C testing tools
use lib qw(t/tlib);
use PerlCriticTestUtils qw(pcritique);
PerlCriticTestUtils::block_perlcriticrc();

COMPLETENESS: {
    my $code = <<'END_PERL';
    my $data = 'foo';
    my $data3 = 'bar';
    my @obj4 = qw( Moe Larry Curly );
    my %user5 = ();
    print $1; # This is OK
END_PERL

    my $policy = 'Bangs::ProhibitNumberedNames';
    is( pcritique($policy, \$code), 3, $policy);
}
