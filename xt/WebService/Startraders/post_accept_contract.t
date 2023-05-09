use Test2::V0 -target => 'WebService::Spacetraders';

my $api = $CLASS->new;

my $contract_id      = 'clheol90v4wmas60dyns3uboy';
my $contract_accepted = $api->accept_contract($contract_id);

# As we've already accepted the contract, we get the error
is $contract_accepted->{error}, {
    'code'    => 4501,
    'data'    => { 'contractId' => 'clheol90v4wmas60dyns3uboy', },
    'message' =>
        'Accept contract failed. Contract clheol90v4wmas60dyns3uboy has already been accepted.',
};

done_testing;