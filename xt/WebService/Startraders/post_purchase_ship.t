use Test2::V0 -target => 'WebService::Spacetraders';

my $api = $CLASS->new;

my $purchase = $api->purchase_ship('SHIP_MINING_DRONE','X1-DF55-69207D');

# This will obviously fail when credits change etc.
is $purchase->{error}, {
          'data' => {
                      'creditsAvailable' => 73240,
                      'creditsNeeded' => 87220
                    },
          'message' => 'Failed to purchase ship. Agent has insufficient funds.',
          'code' => 4216,
};

done_testing;