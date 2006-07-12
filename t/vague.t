use strict;
use warnings;
use Test::More tests => 3;
use Perl::Critic::Config;
use Perl::Critic;

BEGIN {
    use_ok( 'Perl::Critic::Policy::Bangs::ProhibitVagueNames' );
}

# common P::C testing tools
use lib qw(t/tlib);
use PerlCriticTestUtils qw(pcritique);
PerlCriticTestUtils::block_perlcriticrc();

COMPLETENESS: {
    my $code = <<'END_PERL';
    my $data = 'foo';
    my $obj = bless {}, 'Class::Name';
    my $target_user = "Named well";
    my $tmp = 12;
    my $temp = $a;
    my $var = "Duh, it's a var.";
    my $data2 = "This will not fail, but will be picked up by ProhibitNumberedNames";
END_PERL

    my $policy = 'Bangs::ProhibitVagueNames';
    is( pcritique($policy, \$code), 5, $policy);
}

ALL_FORMS: {
    my $code = <<'END_PERL';
    my $var = 'crap';
    my @var = qw( crap crap );
    my %var = ( crap => 'crap' );
END_PERL

    my $policy = 'Bangs::ProhibitVagueNames';
    is( pcritique($policy, \$code), 3, $policy);
}
