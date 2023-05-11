use Test2::V0 -target => 'WebService::Spacetraders';

my $api = $CLASS->new;

is $api->sell(
    "symbol" => "QUARTZ_SAND",
    "units"  => "1",
    'ship'   => 'AKAGEW-3',
    ),
    {
        error => {
            code => 400,
            message => E,
            data => {
                waypointSymbol => 'X1-DF55-17335A',
            },
        },
    };

done_testing;