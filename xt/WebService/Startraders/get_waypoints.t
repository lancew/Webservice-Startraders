use Test2::V0 -target => 'WebService::Spacetraders';

my $api = $CLASS->new;

my $waypoints = $api->get_waypoints('X1-DF55');
is 0 + @$waypoints, 10, '10 Elements in the array of waypoints';

is $waypoints->[0]->{symbol}, 'X1-DF55-20250Z';

done_testing;