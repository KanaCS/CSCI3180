use strict;
use warnings;
require "./Player.pm";

package Jail;
sub new {
    my $class = shift;
    my $self  = {};
    bless $self, $class;
    return $self;
}

sub print {
    print("Jail ");
}

sub stepOn {

	print "Pay \$1000 to reduce the prison round to 1? [y/n]\n";
    while(1){
        my $input = <STDIN>;
        chomp $input;
        if ($input eq 'y'){
        	if($main::cur_player->{"money"} >= 1000){
           		local $Player::prison_rounds = 1;
                $main::cur_player->putToJail();
          		last;
        	}
        	else{
        		print "You do not have enough money to reduce the prison round!\n";
                $main::cur_player->putToJail();
            	last;
        	}
        }
        elsif ($input eq 'n'){
            $main::cur_player->putToJail();
            last;
        }
        else{
            print "Please enter [y] or [n].\n"
        }
    }
}

1;
