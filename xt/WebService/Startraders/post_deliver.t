use Test2::V0 -target => 'WebService::Spacetraders';

my $api = $CLASS->new;

is $api->deliver(
    contract    => 'clheol90v4wmas60dyns3uboy',
    shipSymbol  => 'shipSymbol',
    tradeSymbol => 'COPPER_ORE',
    units       => 100,
    ),
    {

    };

done_testing;