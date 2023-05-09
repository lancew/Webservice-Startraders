use Test2::V0 -target => 'WebService::Spacetraders';

my $api = $CLASS->new;

my $contract_id = 'clheol90v4wmas60dyns3uboy';
my $contract    = $api->get_contract($contract_id);

is $contract,
    {
    'accepted'      => bless( do { \( my $o = 1 ) }, 'JSON::PP::Boolean' ),
    'expiration'    => '2023-05-11T10:09:34.444Z',
    'factionSymbol' => 'COSMIC',
    'fulfilled'     => bless( do { \( my $o = 0 ) }, 'JSON::PP::Boolean' ),
    'id'            => 'clheol90v4wmas60dyns3uboy',
    'terms'         => {
        'deadline' => '2023-05-15T10:09:34.444Z',
        'deliver'  => [
            {   'destinationSymbol' => 'X1-DF55-20250Z',
                'tradeSymbol'       => 'ALUMINUM_ORE',
                'unitsFulfilled'    => 0,
                'unitsRequired'     => 14200
            }
        ],
        'payment' => {
            'onAccepted'  => 147680,
            'onFulfilled' => 590720
        }
    },
    'type' => 'PROCUREMENT'
    };

done_testing;