use strict;
use warnings;
package Land;

sub new {
    my $class = shift;
    my $self  = {
        owner => undef,
        level => 0,
    };
    bless $self, $class;
    return $self;
}

sub print {
    my $self = shift;
    if (!defined($self->{owner})) {
        print("Land ");
    } else {
        print("$self->{owner}->{name}:Lv$self->{level}");
    }
}

sub buyLand {
    my $self = shift;
    if($main::cur_player->{"money"} < 1100){
        print "You do not have enough money to buy the land!\n";
       return 0;
    }
    $self->{"owner"} = $main::cur_player;
    local $Player::tax_rate = 0;
    local $Player::due = 1000;
    local $Player::handling_fee_rate = 0.1;
    $main::cur_player->payDue();
}

sub upgradeLand {
    my $self = shift;

    my $mul_idx = ($self->{"level"}<2)? ($self->{"level"}+1):5;

    if($main::cur_player->{"money"} < (1000*$mul_idx)*1.1){
        print "You do not have enough money to upgrade the land!\n";
       return 0;
    }
    local $Player::tax_rate = 0;
    local $Player::due = 1000*$mul_idx;
    local $Player::handling_fee_rate = 0.1;

    $main::cur_player->payDue();
    $self->{"level"} = $self->{"level"} + 1;
}

sub chargeToll {
    my $self = shift;
    my $mul_idx = ($self->{"level"}<3)? ($self->{"level"}+1):6;

    my $pay = $main::cur_player->{"money"} <= (500*$mul_idx) ? $main::cur_player->{"money"}:(500*$mul_idx);

    local $Player::tax_rate = 0;
    local $Player::due = $pay;
    local $Player::handling_fee_rate = 0;
    $main::cur_player->payDue();

    local $Player::income = $pay;
    local $Player::tax_rate = 0.1 + 0.05*$self->{"level"};
    local $Player::due = 0;
    $self->{owner}->payDue();
}

sub stepOn {
    my $self = shift;
    if(! defined $self->{"owner"}){
        print "Pay \$1000 to buy the land? [y/n]\n";
        #get user input
        while(1){
            my $input = <STDIN>;
            chomp $input;
            if ($input eq 'y'){
                $self->buyLand();
                last;
            }
            elsif ($input eq 'n'){
                last;
            }
            else{
                print "Please enter [y] or [n].\n"
            }
        }
    }
    elsif($self->{"owner"}->{"name"} eq $main::cur_player->{"name"}){
        if($self->{"level"} < 3){
            my $mul_idx = ($self->{"level"}<2)? ($self->{"level"}+1):5;
            my $pay = 1000*$mul_idx;
            print "Pay \$$pay to upgrade the land? [y/n]\n";
            #get user input
            while(1){
                my $input = <STDIN>;
                chomp $input;
                if ($input eq 'y'){
                    $self->upgradeLand();
                    last;
                }
                elsif ($input eq 'n'){
                    last;
                }
                else{
                    print "Please enter [y] or [n].\n"
                }
            }
        }
    }
    else{
        my $mul_idx = ($self->{"level"}<3)? ($self->{"level"}+1):6;
        my $pay = 500*$mul_idx;
        print "You need to pay player ",$self->{"owner"}->{"name"}," \$$pay\n";
        $self->chargeToll();
    }
}
1;