use Test2::V0 -target => 'WebService::Spacetraders';

my $api = $CLASS->new;

my $waypoint='X1-DF55-69207D';
is $api->get_market($waypoint),
{
    exchange => E,
    exports  => E,
    imports  => E,
    symbol   => 'X1-DF55-69207D',
    tradeGoods => E,
    transactions => E,

};

done_testing;