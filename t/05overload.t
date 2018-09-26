# Tests for overloads (+,-,<,>, etc)
use Test;
BEGIN { plan tests => 2 }
use Time::Piece;
my $t = localtime;
my $s = Time::Seconds->new(15);
eval { my $result = $t + $s };
ok($@, "", "Adding Time::Seconds does not cause runtime error");


# Test subtracting two different times with different islocal values.
my $local = Time::Piece->new();
$local->[Time::Piece::c_islocal] = 1;
my $notlocal = Time::Piece->new();
$notlocal->[Time::Piece::c_islocal] = 0;

my $t1 = $local->strptime( '2018-09-26 12:00:00', '%Y-%m-%d %H:%M:%S' );
my $t2 = $notlocal->strptime( '2018-09-26 13:00:00', '%Y-%m-%d %H:%M:%S' );

my $diff = $t2 - $t1;
ok( $diff->seconds, 3600, "Should be one hour difference between the times" );
