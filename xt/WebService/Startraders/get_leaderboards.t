use Test2::V0 -target => 'WebService::Spacetraders';

my $api = $CLASS->new;

is $api->get_leaderboards, {
    mostCredits         => E,
    mostSubmittedCharts => E,
};

done_testing;