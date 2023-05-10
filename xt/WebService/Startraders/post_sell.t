use Test2::V0 -target => 'WebService::Spacetraders';

my $api = $CLASS->new;

is $api->sell(
    "symbol" => "QUARTZ_SAND",
    "units"  => "1",
    'ship'   => 'AKAGEW-3',
    ),
    {
    agent       => E,
    cargo       => E,
    transaction => E,
    };

done_testing;