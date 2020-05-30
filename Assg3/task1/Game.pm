use strict;
use warnings;

package Game;
use MannerDeckStudent; 
use Player;

sub new {
	my $class = shift @_;
	my $deck = new Deck();
	my @player = ();
	my @cards = ();
	my $self = {
		"deck"=>\$deck, "players"=>\@player, "cards"=>\@cards,
	};
	return bless $self, $class;
}

sub setPlayers {
	my ($self,$players_name) = @_;
	# print "players ", @$players_name[0], "\n";
	my $playera;
	my $player_name;
	foreach $player_name (@$players_name){
		$playera = new Player($player_name);
		push (@{$self->{"players"}}, $playera);
	}	
	#print "num of players ", $#{$self->{"players"}}, "\n";
	return \@{$self->{"players"}};
}

sub getReturn {
	my ($self) = @_;
	my $num = $#{$self->{"cards"}};
	#return can start when there are at least 2 cards on stack
	if ($num > 0){ 
		my $newcard = @{$self->{"cards"}}[$num];

		if ($newcard eq "J"){
			#print "return:(all) ", ($num + 1), "\n";
			return ($num + 1);
		}
		else{
			#print "last c: ",$newcard,"\n";
			my $i = 0;
			for($i=0; $i<=$num; $i=$i+1){
				if((@{$self->{"cards"}}[$i] eq $newcard) and $i<$num){
					#print "return: ", ($num - $i + 1), "\n";
					return ($num - $i + 1);
				}
			}
		}
	}
	#print "return: 0\n";
	return 0;
}

sub showCards {
	my ($self) = @_;
	my $num = $#{$self->{"cards"}};
	#dont start printing when no cards there
	if ($num >= 0){
		my $newcard = @{$self->{"cards"}}[$num];
		my $i = 0;
		for($i=0; $i<=$num; $i=$i+1){
			print @{$self->{"cards"}}[$i]," ";
		}
		print "\n";
	}
}

sub startGame {
	my ($self) = @_;

	if ((($#{$self->{"players"}}+1) == 0) or (52 % ($#{$self->{"players"}}+1) != 0)){
		print "Error: cards' number 52 can not be divided by players number ", $#{$self->{"players"}}+1, "!\n";
		exit 0;
	}
	else{
		print "There ",($#{$self->{"players"}}+1)," players in the game:\n";
		my $p;
		foreach $p (@{$self->{"players"}}){
			print ${$p->{name}}," ";
		}
		print "\n";

		print "\nGame begin!!!\n";

		#shuffle cards
		${$self->{"deck"}}->shuffle();

		#separate cards
		my $num = $#{$self->{"players"}}+1;
		my @ret = ${$self->{"deck"}}->AveDealCards($num);

		#deliver cards
		my $i = 0;
		for($i=0; $i<=$#{$self->{"players"}}; $i=$i+1){
			$self->{"players"}[$i]->getCards(@{$ret[$i]});
			#print ${$self->{"players"}[$i]->{"name"}},": ", @{$self->{"players"}[$i]->{"cards"}},"\n";
		}

		#game start
		my $turn = 0; #player turn
		my $count = 0;
		while ($#{$self->{"players"}} > 0){ # DEBUG: ($count < 20)
			if ($turn >= $num){
				$turn = 0;
				$count = $count + 1;
			}
			#put cards from player cards to public stack
			my $card = @{$self->{"players"}[$turn]->{"cards"}}[0];

			print "\nPlayer ",${$self->{"players"}[$turn]->{"name"}}," has ", $#{$self->{"players"}[$turn]->{"cards"}}+1, " cards before deal.\n";

			print "=====Before player's deal=======\n";
			print join(" ",@{$self->{"cards"}}),"\n";
			print "================================\n";

			shift(@{$self->{"players"}[$turn]->{"cards"}});
			push(@{$self->{"cards"}}, $card);
			print ${$self->{"players"}[$turn]->{"name"}}, " ==> card ",$card,"\n";

			#getReturns
			my $return = $self->getReturn();
			while($return > 0){
				push(@{$self->{"players"}[$turn]->{"cards"}}, @{$self->{"cards"}}[-1]);
				pop(@{$self->{"cards"}});
				$return = $return - 1;
			}

			print "=====After player's deal=======\n";
			print join(" ",@{$self->{"cards"}}),"\n";
			print "================================\n";
			print "Player ",${$self->{"players"}[$turn]->{"name"}}," has ", $#{$self->{"players"}[$turn]->{"cards"}}+1, " cards after deal.\n";

			if($#{$self->{"players"}[$turn]->{"cards"}} == -1){
				print "Player ",${$self->{"players"}[$turn]->{"name"}}," has no cards, out!\n";
				splice(@{$self->{"players"}}, $turn, 1);
				$num = $num - 1;
				$turn = $turn - 1;
			}

			$turn = $turn + 1;
		}
		print "\nWinner is ", ${$self->{"players"}[0]->{"name"}}, " in game ", $count+1,"\n";

	}
}

return 1;
