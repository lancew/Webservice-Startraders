use Test2::V0 -target => 'WebService::Spacetraders';

my $api = $CLASS->new;

is $api->get_my_factions, [{
    reputation => E,
    symbol     => E,
}];

done_testing;