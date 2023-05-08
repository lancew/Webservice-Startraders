use Test2::V0 -target => 'WebService::Spacetraders';

my $api = $CLASS->new;

is $api->get_my_agent, {
    'accountId'    => E,
    'credits'      => E,
    'headquarters' => E,
    'symbol'       => E,
};

done_testing;