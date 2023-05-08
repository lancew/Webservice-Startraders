use Test2::V0 -target => 'WebService::Spacetraders';

my $api = $CLASS->new;


is $api->get_waypoint('X1-DF55-69207D'), {
          'chart' => {
                       'submittedBy' => 'COSMIC',
                       'submittedOn' => '2023-01-23T17:20:37.035Z'
                     },
          'faction' => {
                         'symbol' => 'COSMIC'
                       },
          'orbitals' => [],
          'symbol' => 'X1-DF55-69207D',
          'systemSymbol' => 'X1-DF55',
          'traits' => [
                        {
                          'description' => 'A fortified stronghold housing armed forces, advanced weaponry, and strategic assets for defense or offense.',
                          'name' => 'Military Base',
                          'symbol' => 'MILITARY_BASE'
                        },
                        {
                          'description' => 'A critical junction in the galaxy\'s trade network, with countless goods and services flowing through daily.',
                          'name' => 'Trading Hub',
                          'symbol' => 'TRADING_HUB'
                        },
                        {
                          'description' => 'A thriving center of commerce where traders from across the galaxy gather to buy, sell, and exchange goods.',
                          'name' => 'Marketplace',
                          'symbol' => 'MARKETPLACE'
                        },
                        {
                          'description' => 'A bustling hub for the construction, repair, and sale of various spacecraft, from humble shuttles to mighty warships.',
                          'name' => 'Shipyard',
                          'symbol' => 'SHIPYARD'
                        }
                      ],
          'type' => 'ORBITAL_STATION',
          'x' => 32,
          'y' => -38

};

done_testing;