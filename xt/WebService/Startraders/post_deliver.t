use Test2::V0 -target => 'WebService::Spacetraders';

my $api = $CLASS->new;

is $api->contract_deliver(
    contract    => 'clheol90v4wmas60dyns3uboy',
    shipSymbol  => 'shipSymbol',
    tradeSymbol => 'COPPER_ORE',
    units       => 100,
    ),
    {
    error => {
        code    => 400,
        message => 'Ship shipSymbol does not exist.',

    },

    };

done_testing;