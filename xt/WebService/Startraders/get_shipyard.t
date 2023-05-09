use Test2::V0 -target => 'WebService::Spacetraders';

my $api = $CLASS->new;

my $yard = $api->get_shipyard('X1-DF55-69207D');

my @keys = sort keys %$yard;
is \@keys, [ 'shipTypes', 'ships', 'symbol', 'transactions' ];

is $yard->{ships}[0],
    {
    'description' =>
        'A small, unmanned spacecraft that can be launched into orbit to gather data and perform basic tasks.',
    'engine' => {
        'description' =>
            'A basic low-energy propulsion system that generates thrust for interplanetary travel.',
        'name'         => 'Impulse Drive I',
        'requirements' => {
            'crew'  => 0,
            'power' => 1
        },
        'speed'  => 2,
        'symbol' => 'ENGINE_IMPULSE_DRIVE_I'
    },
    'frame' => {
        'description' =>
            'A small, unmanned spacecraft used for exploration, reconnaissance, and scientific research.',
        'fuelCapacity'   => 0,
        'moduleSlots'    => 0,
        'mountingPoints' => 0,
        'name'           => 'Frame Probe',
        'requirements'   => {
            'crew'  => 0,
            'power' => 1
        },
        'symbol' => 'FRAME_PROBE'
    },
    'modules'       => [],
    'mounts'        => [],
    'name'          => 'Probe Satellite',
    'purchasePrice' => 67830,
    'reactor'       => {
        'description' =>
            'A basic solar power reactor, used to generate electricity from solar energy.',
        'name'         => 'Solar Reactor I',
        'powerOutput'  => 3,
        'requirements' => { 'crew' => 0 },
        'symbol'       => 'REACTOR_SOLAR_I'
    },
    'type' => 'SHIP_PROBE'
    };

done_testing;