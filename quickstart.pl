# Example in perl for https://docs.spacetraders.io/quickstart

use strict;
use warnings;

use Data::Dumper;
$Data::Dumper::Sortkeys=1;

use lib './lib';
use WebService::Spacetraders;

my $api = WebService::Spacetraders->new;

my $agent = $api->get_my_agent;
warn Dumper $agent;
=pod

my $waypoint = $api->get_waypoint($agent->{headquarters});
warn Dumper $waypoint;

my $contract_id = 'clheol90v4wmas60dyns3uboy';
my $contract = $api->get_contract($contract_id);
warn Dumper $contract;

#my $contract_accpted = $api->accept_contract($contract_id);
#warn Dumper $contract_accpted;

my $waypoints = $api->get_waypoints('X1-DF55');
warn Dumper $waypoints;

my $shipyard = $api->get_shipyard('X1-DF55-69207D');
warn Dumper $shipyard;
=cut

my $ships = $api->get_my_ships;
warn Dumper $ships;
=pod
my $purchase = $api->purchase_ship('SHIP_MINING_DRONE','X1-DF55-69207D');
warn Dumper $purchase;

my $navigate = $api->navigate('AKAGEW-3','X1-DF55-17335A');
warn Dumper $navigate;

my $dock = $api->dock('AKAGEW-3');
warn Dumper $dock;

my $refuel = $api->refuel('AKAGEW-3');
warn Dumper $refuel;

=cut

my $orbit = $api->orbit('AKAGEW-3');
warn Dumper $orbit;
