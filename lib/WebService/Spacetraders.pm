package WebService::Spacetraders;

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

    return $json->{data};
}

sub get_my_agent {
    my $self = shift;

    return $self->_make_request( $self->url . 'my/agent', );
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

sub get_my_ships {
    my $self = shift;

    my $url = $self->url . 'my/ships';

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

1;