use strict;
use warnings;

package GoldenHookFishing;
use Game;

my $game = Game->new();
if ($game->setPlayers(['lin', 'liz', 'wu','a','b','c','d','e','1','2','3','4','5'])) {
	$game->startGame();
}
