use strict;
use warnings;

package GoldenHookFishing;
use Game;

our $x="our_x\n";
our $y="our_y\n";

sub func1{
    print("$x$y");
}
sub func2{
    local $x="local_x\n";
    $y="my_y\n";
    func1();
}
func1();
func2();
func1();

