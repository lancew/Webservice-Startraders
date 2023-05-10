use Test2::V0 -target => 'WebService::Spacetraders';

my $api = $CLASS->new;

my $ships = $api->get_my_ships;
is @$ships, 3;
my @ship_keys = sort keys %{ $ships->[0] };
is \@ship_keys, [
    'cargo',
    'crew',
    'engine',
    'frame',
    'fuel',
    'modules',
    'mounts',
    'nav',
    'reactor',
    'registration',
    'symbol'
];

is $api->get_my_ships('AKAGEW-3'),
{
    'cargo' => E,
    'crew' => E,
    'engine' => E,
    'frame' => E,
    'fuel' => E,
    'modules' => E,
    'mounts' => E,
    'nav' => E,
    'reactor' => E,
    'registration' => E,
    'symbol' => E,
};



done_testing;