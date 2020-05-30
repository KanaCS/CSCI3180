use strict;
use warnings;
 
package Player;
sub new {
	my $class = shift;
	my $name = shift @_;
	my @cards = ();
	my $self = {
		"name"=>\$name, "cards"=>\@cards,
	};
	return bless $self, $class;
}

sub getCards {
	my ($self, @card) = @_;
	push (@{$self->{"cards"}}, @card);
	return \@{$self->{"cards"}};
}

sub dealCards {
	my ($self) = @_;
	my @cards = @{$self->{"cards"}};
	my $deal = $cards[0];
	shift (@cards);
	#print "remaining:",@cards, "\n";
	return $deal;
}

sub numCards {
	my ($self) = @_;
	return $#{$self->{"cards"}};
}

return 1;