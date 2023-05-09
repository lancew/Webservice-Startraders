use Test2::V0 -target => 'WebService::Spacetraders';

my $api = $CLASS->new;

my $navigate = $api->navigate( 'AKAGEW-3', 'X1-DF55-17335A' );

# As we've already navigated here so we get the error
is $navigate->{error},
    {
        'code' => 4204,
        'data' => {
            'destinationSymbol' => 'X1-DF55-17335A',
            'shipSymbol'        => 'AKAGEW-3'
        },
        'message' =>
            'Navigate request failed. Ship AKAGEW-3 is currently located at the destination.'
    };

done_testing;