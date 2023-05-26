package WebService::Spacetraders;
 # ABSTRACT: Wrapper for the Spacetraders.io api

use strict;
use warnings;

use Moo;
use HTTP::Tiny;
use JSON::MaybeXS;

use namespace::clean;

has token => (
    is      => 'ro',
    default => sub {
        my $token = $ENV{SPACETRADERS_IO_TOKEN};
        die
            'You must set the environment variable SPACETRADERS_IO_TOKEN or set token'
            unless $token;
        return $token;
    },
);

has http => (
    is      => 'ro',
    default => sub {
        return HTTP::Tiny->new();
    },
);

has url => (
    is      => 'ro',
    default => sub {
        return 'https://api.spacetraders.io/v2/';
    },
);

# ------------------------------

sub _make_request {
    my ( $self, $url, $method, $data ) = @_;

    my $content = undef;
    if ($data) {
        $content = encode_json($data);
    }

    my $response = $self->http->request(
        $method || 'GET',
        $url,
        {   headers => {
                Authorization  => 'Bearer ' . $self->token,
                'Content-Type' => 'application/json',
            },
            content => $content,
        }
    );

    if ( !$response->{success} ) {
        if ( $response->{content} ) {
            return decode_json $response->{content};
        }
        return 'Response error';
    }

    my $json = decode_json $response->{content};

    # Normally there is a "data" element that we want, BUT
    # in case of some (like the general status) we just want
    # the full JSON of there is not a data element
    return $json->{data} || $json;
}


# ----------------------------------
sub register {
    my ($self, %params) = @_;
    die 'callsign not present' unless $params{callsign};
    die 'faction not present' unless $params{faction};

    my $url = $self->url . 'register';

    return $self->_make_request( $url, 'POST', {
        symbol => $params{callsign},
        faction => $params{faction},
    });
}


sub get_my_agent {
    my $self = shift;

    return $self->_make_request( $self->url . 'my/agent', );
}

sub get_status {
    my $self = shift;

    return ($self->_make_request( $self->url ));
}


sub get_leaderboards {
    my $self = shift;

    return ($self->get_status)->{leaderboards};
}

sub get_my_factions {
    my $self = shift;

    return $self->_make_request( $self->url . 'my/factions', );
}

sub get_waypoint {
    my ( $self, $waypoint ) = @_;

    my @waypoint_parts = split( '-', $waypoint );
    my $system         = $waypoint_parts[0] . '-' . $waypoint_parts[1];
    my $url = $self->url . 'systems/' . $system . '/waypoints/' . $waypoint;

    return $self->_make_request( $url, );

}

sub get_waypoints {
    my ( $self, $system ) = @_;
    die 'No system provided' unless $system;

    my $url = $self->url . 'systems/' . $system . '/waypoints/';

    return $self->_make_request( $url, );
}

sub get_contract {
    my ( $self, $contract_id ) = @_;
    die 'No contract_id provided' unless $contract_id;

    my $url = $self->url . 'my/contracts/' . $contract_id;
    
    return $self->_make_request( $url, );
}

sub accept_contract {
    my ( $self, $contract_id ) = @_;
    die 'No contract_id provided' unless $contract_id;

    my $url = $self->url . 'my/contracts/' . $contract_id . '/accept';

    return $self->_make_request( $url, 'POST' );
}

sub contract_deliver {
    my ( $self, %params ) = @_;
    die 'contract is missing' unless $params{contract};
    die 'tradeSymbol is missing' unless $params{'tradeSymbol'};
    die 'units is missing' unless $params{'units'};
    die 'shipSymbol is missing' unless $params{'shipSymbol'};

    my $url = $self->url . 'my/contracts/' . $params{contract} . '/deliver';

    return $self->_make_request( $url, 'POST', {%params});
}

sub fulfill_contract {
    my ( $self, $contract_id ) = @_;
    die 'No contract_id provided' unless $contract_id;

    my $url = $self->url . 'my/contracts/' . $contract_id . '/fultill';

    return $self->_make_request( $url, 'POST' );
}

sub get_shipyard {
    my ( $self, $waypoint ) = @_;
    die 'No waypoint provided' unless $waypoint;

    my @waypoint_parts = split( '-', $waypoint );
    my $system         = $waypoint_parts[0] . '-' . $waypoint_parts[1];

    my $url
        = $self->url
        . 'systems/'
        . $system
        . '/waypoints/'
        . $waypoint
        . '/shipyard';

    return $self->_make_request($url);
}

sub get_market {
    my ( $self, $waypoint ) = @_;
    die 'No waypoint provided' unless $waypoint;

    my @waypoint_parts = split( '-', $waypoint );
    my $system         = $waypoint_parts[0] . '-' . $waypoint_parts[1];

    my $url
        = $self->url
        . 'systems/'
        . $system
        . '/waypoints/'
        . $waypoint
        . '/market';

    return $self->_make_request($url);
}

sub get_my_ships {
    my $self = shift;
    my $ship_id = shift || '';

    my $url = $self->url . 'my/ships/' . $ship_id;

    return $self->_make_request($url);
}

sub purchase_ship {
    my ( $self, $ship_type, $waypoint ) = @_;
    die 'No ship_type provided' unless $ship_type;
    die 'No waypoint provided'  unless $waypoint;

    my $url = $self->url . 'my/ships';
    my $data = {
        shipType       => $ship_type,
        waypointSymbol => $waypoint,
    };

    return $self->_make_request( $url, 'POST', $data );
}

sub navigate {
    my ( $self, $ship, $waypoint ) = @_;
    die 'No ship provided'     unless $ship;
    die 'No waypoint provided' unless $waypoint;

    my $url  = $self->url . 'my/ships/' . $ship . '/navigate';
    my $data = { waypointSymbol => $waypoint };

    return $self->_make_request( $url, 'POST', $data );
}

sub dock {
    my ( $self, $ship ) = @_;
    die 'No ship provided' unless $ship;

    my $url = $self->url . 'my/ships/' . $ship . '/dock';

    return $self->_make_request( $url, 'POST' );
}

sub refuel {
    my ( $self, $ship ) = @_;
    die 'No ship provided' unless $ship;

    my $url = $self->url . 'my/ships/' . $ship . '/refuel';

    return $self->_make_request( $url, 'POST' );
}

sub orbit {
    my ( $self, $ship ) = @_;
    die 'No ship provided' unless $ship;

    my $url = $self->url . 'my/ships/' . $ship . '/orbit';

    return $self->_make_request( $url, 'POST' );
}

sub extract {
    my ( $self, $ship ) = @_;
    die 'No ship provided' unless $ship;

    my $url = $self->url . 'my/ships/' . $ship . '/extract';

    return $self->_make_request( $url, 'POST' );
}

sub sell {
    my ( $self, %params ) = @_;
    die 'symbol is missing' unless $params{'symbol'};
    die 'units is missing' unless $params{'units'};
    die 'ship is missing' unless $params{'ship'};

    my $url = $self->url . 'my/ships/' . $params{ship} . '/sell';

    return $self->_make_request( $url, 'POST', {%params});
}

1;