# Example in perl for https://docs.spacetraders.io/quickstart

use strict;
use warnings;

use Data::Dumper;
$Data::Dumper::Sortkeys=1;

use lib './lib';
use Webservice::Spacetraders;

my $api = Webservice::Spacetraders->new;

=pod
my $agent = $api->get_my_agent;
warn Dumper $agent;

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

my $ships = $api->get_my_ships;
warn Dumper $ships;
=cut

my $purchase = $api->purchase_ship('SHIP_MINING_DRONE','X1-DF55-69207D');
warn Dumper $purchase;