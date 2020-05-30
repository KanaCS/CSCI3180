#! /usr/bin/perl
use warnings;
use strict;
require "./Bank.pm";
require "./Jail.pm";
require "./Land.pm";
require "./Player.pm";

our @game_board = (
    new Bank(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Jail(),
    new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(),
    new Jail(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Jail(),
    new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(), new Land(),
);
our $game_board_size = @game_board;

our @players = (new Player("A"), new Player("B"));
our $num_players = @players;

our $cur_player_idx = 0;
our $cur_player = $players[$cur_player_idx];
our $cur_round = 0;
our $num_dices = 1;
srand(0); # don't touch

# game board printing utility. Used to show player position.
sub printCellPrefix {
    my $position = shift;
    my @occupying = ();
    foreach my $player (@players) {
        if ($player->{position} == $position && $player->{money} > 0) {
            push(@occupying, ($player->{name}));
        }
    }
    print(" " x ($num_players - scalar @occupying), @occupying);
    if (scalar @occupying) {
        print("|");
    } else {
        print(" ");
    }
}

sub printGameBoard {
    print("-"x (10 * ($num_players + 6)), "\n");
    for (my $i = 0; $i < 10; $i += 1) {
        printCellPrefix($i);
        $game_board[$i]->print();
    }
    print("\n\n");
    for (my $i = 0; $i < 8; $i += 1) {
        printCellPrefix($game_board_size - $i - 1);
        $game_board[-$i-1]->print();
        print(" "x (8 * ($num_players + 6)));
        printCellPrefix($i + 10);
        $game_board[$i+10]->print();
        print("\n\n");
    }
    for (my $i = 0; $i < 10; $i += 1) {
        printCellPrefix(27 - $i);
        $game_board[27-$i]->print();
    }
    print("\n");
    print("-"x (10 * ($num_players + 6)), "\n");
}

sub terminationCheck {
    for my $i (0..1){
        if($players[$i]->{"money"}<=0){
            print "Game over! winner: ",$players[$i^1]->{"name"},"\n";
            return 0;
        }
    }
    return 1;
}

sub throwDice {
    my $step = 0;
    for (my $i = 0; $i < $num_dices; $i += 1) {
        $step += 1 + int(rand(6));
    }
    return $step;
}

sub main {
    my $dice;
    while (terminationCheck()){
        $cur_round = $cur_round + 1;
        $cur_player = $players[$cur_player_idx];
        
        if($cur_player->{"num_rounds_in_jail"}<=0){
            printGameBoard();
            foreach my $player (@players) {
                $player->printAsset();
            }
        }

        local $Player::tax_rate = 0;
        $cur_player->payDue();
        
        if($cur_player->{"num_rounds_in_jail"}>0){
            $main::cur_player->move(0);
            $cur_player_idx = $cur_player_idx^1;
            next;
        }

        print "Player ",$cur_player->{"name"},"’s turn.\n";
        print "Pay \$500 to throw two dice? [y/n]\n";
        #get user input
        while(1){
            my $input = <STDIN>;
            chomp $input;
            if ($input eq 'y'){
                if($cur_player->{"money"}<500*1.05){
                    print "You do not have enough money to throw two dice!\n";
                    $dice = &throwDice();

                }
                else{
                    local $Player::tax_rate = 0;
                    local $Player::due = 500;
                    local $Player::handling_fee_rate = 0.05;
                    $cur_player->payDue();
                    local $num_dices = 2;
                    $dice = throwDice();
                }
                last;
            }
            elsif ($input eq 'n'){
                $dice = throwDice();
                last;
            }
            else{
                print "Please enter [y] or [n].\n"
            }
        }
        print "Points of dice: $dice\n";
        $main::cur_player->move($dice);

        $game_board[$main::cur_player->{"position"}]->stepOn();
        
        $cur_player_idx = $cur_player_idx^1;
    }
}

main();
