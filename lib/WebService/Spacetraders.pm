use strict;
use warnings;

package WebService::Spacetraders;

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

sub get_my_agent {
    my $self = shift;

    my $response = $self->http->request(
        'GET',
        $self->url . 'my/agent',
        { headers => { Authorization => 'Bearer ' . $self->token } }
    );

    if ( !$response->{success} ) {
        return 'Response error';
    }

    my $json = decode_json $response->{content};

    return $json->{data};
}

sub get_waypoint {
    my ( $self, $waypoint ) = @_;

    my @waypoint_parts = split( '-', $waypoint );
    my $system         = $waypoint_parts[0] . '-' . $waypoint_parts[1];

    my $response = $self->http->request(
        'GET',
        $self->url . 'systems/' . $system . '/waypoints/' . $waypoint,
        { headers => { Authorization => 'Bearer ' . $self->token } }
    );

    if ( !$response->{success} ) {
        return 'Response error';
    }

    my $json = decode_json $response->{content};

    return $json->{data};
}

sub get_waypoints {
    my ( $self, $system ) = @_;
    die 'No system provided' unless $system;

    my $response = $self->http->request(
        'GET',
        $self->url . 'systems/' . $system . '/waypoints/',
        { headers => { Authorization => 'Bearer ' . $self->token } }
    );

    if ( !$response->{success} ) {
        return 'Response error';
    }

    my $json = decode_json $response->{content};

    return $json->{data};
}

sub get_contract {
    my ( $self, $contract_id ) = @_;
    die 'No contract_id provided' unless $contract_id;

    my $response = $self->http->request(
        'GET',
        $self->url . 'my/contracts/' . $contract_id,
        { headers => { Authorization => 'Bearer ' . $self->token } }
    );

    if ( !$response->{success} ) {
        return 'Response error';
    }

    my $json = decode_json $response->{content};

    return $json->{data};
}

sub accept_contract {
    my ( $self, $contract_id ) = @_;
    die 'No contract_id provided' unless $contract_id;

    my $response = $self->http->request(
        'POST',
        $self->url . 'my/contracts/' . $contract_id . '/accept',
        { headers => { Authorization => 'Bearer ' . $self->token } }
    );

    if ( !$response->{success} ) {
        return 'Response error';
    }

    my $json = decode_json $response->{content};

    return $json->{data};
}

sub get_shipyard {
    my ( $self, $waypoint ) = @_;
    die 'No waypoint provided' unless $waypoint;

    my @waypoint_parts = split( '-', $waypoint );
    my $system         = $waypoint_parts[0] . '-' . $waypoint_parts[1];

    my $response = $self->http->request(
        'GET',
        $self->url
            . 'systems/'
            . $system
            . '/waypoints/'
            . $waypoint
            . '/shipyard',
        { headers => { Authorization => 'Bearer ' . $self->token } }
    );

    if ( !$response->{success} ) {
        return 'Response error';
    }

    my $json = decode_json $response->{content};

    return $json->{data};
}

sub get_my_ships {
    my $self = shift;

    my $response = $self->http->request(
        'GET',
        $self->url . 'my/ships',
        { headers => { Authorization => 'Bearer ' . $self->token } }
    );

    if ( !$response->{success} ) {
        return 'Response error';
    }

    my $json = decode_json $response->{content};

    return $json->{data};
}

sub purchase_ship {
    my ( $self, $ship_type, $waypoint ) = @_;
    die 'No ship_type provided' unless $ship_type;
    die 'No waypoint provided'  unless $waypoint;

    my $response = $self->http->request(
        'POST',
        $self->url . 'my/ships',
        {   headers => {
                Authorization  => 'Bearer ' . $self->token,
                'Content-Type' => 'application/json',
            },
            content => encode_json(
                {   shipType       => $ship_type,
                    waypointSymbol => $waypoint,
                }
            ),
        }
    );

    if ( !$response->{success} ) {
        use Data::Dumper;
        warn Dumper $response;
        return 'Response error';
    }

    my $json = decode_json $response->{content};

    return $json->{data};
}

sub navigate {
    my ( $self, $ship, $waypoint ) = @_;
    die 'No ship provided'     unless $ship;
    die 'No waypoint provided' unless $waypoint;

    my $response = $self->http->request(
        'POST',
        $self->url . 'my/ships/' . $ship . '/navigate',
        {   headers => {
                Authorization  => 'Bearer ' . $self->token,
                'Content-Type' => 'application/json',
            },
            content => encode_json(
                {
                    waypointSymbol => $waypoint,
                }
            ),
        }
    );

    if ( !$response->{success} ) {
        if ($response->{content}) {
            return decode_json $response->{content};
        }       
        return 'Response error';
    }

    my $json = decode_json $response->{content};

    return $json->{data};
}

sub dock {
    my ($self,$ship) = @_;

    my $response = $self->http->request(
        'POST',
        $self->url . 'my/ships/' . $ship . '/dock',
        {   headers => {
                Authorization  => 'Bearer ' . $self->token,
            },
        }
    );

    if ( !$response->{success} ) {
        if ($response->{content}) {
            return decode_json $response->{content};
        }       
        return 'Response error';
    }

    my $json = decode_json $response->{content};

    return $json->{data};
}

sub refuel {
    my ($self,$ship) = @_;

    my $response = $self->http->request(
        'POST',
        $self->url . 'my/ships/' . $ship . '/refuel',
        {   headers => {
                Authorization  => 'Bearer ' . $self->token,
            },
        }
    );

    if ( !$response->{success} ) {
        if ($response->{content}) {
            return decode_json $response->{content};
        }       
        return 'Response error';
    }

    my $json = decode_json $response->{content};

    return $json->{data};
}

sub orbit {
    my ($self,$ship) = @_;

    my $response = $self->http->request(
        'POST',
        $self->url . 'my/ships/' . $ship . '/orbit',
        {   headers => {
                Authorization  => 'Bearer ' . $self->token,
            },
        }
    );

    if ( !$response->{success} ) {
        if ($response->{content}) {
            return decode_json $response->{content};
        }       
        return 'Response error';
    }

    my $json = decode_json $response->{content};

    return $json->{data};

}

sub extract {
    my ($self,$ship) = @_;

    my $response = $self->http->request(
        'POST',
        $self->url . 'my/ships/' . $ship . '/extract',
        {   headers => {
                Authorization  => 'Bearer ' . $self->token,
            },
        }
    );

    if ( !$response->{success} ) {
        if ($response->{content}) {
            return decode_json $response->{content};
        }       
        return 'Response error';
    }

    my $json = decode_json $response->{content};

    return $json->{data};

}


1;