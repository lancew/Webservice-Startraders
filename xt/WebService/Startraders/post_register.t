use Test2::V0 -target => 'WebService::Spacetraders';

my $api = $CLASS->new;

my $register = $api->register(
    callsign => 'AKAGE',
    faction => 'COSMIC',
);

is $register, {
    error => {
        code => 409,
        message => 'Cannot register agent. Account already has a registered agent: AKAGEW',
    },
};

done_testing;