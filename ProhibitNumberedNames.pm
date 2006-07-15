package Perl::Critic::Policy::Bangs::ProhibitNumberedNames;

use strict;
use warnings;
use Perl::Critic::Utils;
use Perl::Critic::Violation;
use base 'Perl::Critic::Policy';

sub default_severity { return $SEVERITY_MEDIUM }
sub applies_to { return 'PPI::Token::Symbol' }

=head1 NAME

Perl::Critic::Policy::Bangs::ProhibitNumberedNames - Prohibit variables differentiated by trailing numbers

=head1 DESCRIPTION

Similar variables should be obviously different.  A lazy way to
differentiate similar variables is by tacking a number at the end.

    my $total = $price * $quantity;
    my $total2 = $total + ($total * $taxrate);
    my $total3 = $total2 + $shipping;

The difference between C<$total> and C<$total3> is not described
by the silly "3" at the end.  Instead, it should be:

    my $merch_total = $price * $quantity;
    my $subtotal = $merch_total + ($merch_total * $taxrate);
    my $grand_total = $subtotal + $shipping;

See
http://www.oreillynet.com/onlamp/blog/2004/03/the_worlds_two_worst_variable.html
for more of my ranting on this.

=head1 CONSTRUCTOR

Takes no configuration.

=cut

sub new {
    my $class = shift;

    return bless {}, $class;
}


sub violates {
    my ( $self, $elem, $doc ) = @_;

    # make $basename be the variable name with no sigils or namespaces.
    my $canonical = $elem->canonical();
    my $basename = $canonical;
    $basename =~ s/.*:://;
    $basename =~ s/^[\$@%]//;

    if ( $basename =~ /\d+$/ ) {
        my $sev = $self->get_severity();
        my $desc = qq(Variable named "$canonical");
        my $expl = 'Variable names should not be differentiated only by digits';
        return Perl::Critic::Violation->new( $desc, $expl, $elem, $sev );
    }
    return;
}

1;

=head1 AUTHOR

Andy Lester C<< <andy at petdance.com> >> from code by
Andrew Moore C<< <amoore at mooresystems.com> >>.

=head1 ACKNOWLEDGEMENTS

Adapted from policies by Jeffrey Ryan Thalhammer <thaljef@cpan.org>,
Based on App::Fluff by Andy Lester, "<andy at petdance.com>"

=head1 COPYRIGHT

Copyright (c) 2006 Andy Lester.  All rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.  The full text of this license
can be found in the LICENSE file included with this module.

=cut
