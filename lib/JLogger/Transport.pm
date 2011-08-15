package JLogger::Transport;

use strict;
use warnings;

require Carp;

sub new {
    my ($class, %args) = @_;

    Carp::croak('"host" required')   unless exists $args{host};
    Carp::croak('"port" required')   unless exists $args{port};
    Carp::croak('"secret" required') unless exists $args{secret};

    my $self = bless {%args}, $class;

    $self->init;

    $self;
}

sub host { $_[0]->{host} }

sub port { $_[0]->{port} }

sub secret { $_[0]->{secret} }

sub on_message {
    @_ > 1 ? $_->[0]->{on_message} = $_[1] : $_[0]->{on_message};
}

sub init {

}

sub connect {
    my $self = shift;

    Carp::croak(qq(You didn't implemented "connect" in @{[ ref $self ]}));
}

sub disconnect {
    my $self = shift;

    Carp::croak(qq(You didn't implemented "disconnect" in @{[ ref $self ]}));
}

1;
__END__

=head1 NAME

JLogger::Transport - base class for JLogger transport.

=head1 SYNOPSIS

    use base 'JLogger::Transport';

    sub init {
        my $self = shift;

        ...
    }

    sub connect {
        my $self = shift;

        ...
    }

=head1 ATTRIBUTES

JLogger::Transport implements following attributes.

=head2 C<host>
    
    my $host = $transport->host;

=head2 C<port>

    my $port = $transport->port;

=head2 C<secret>

    my $secret = $transport->secret;

=head2 C<on_message>

    $transport->on_message(sub {
        my ($transport, $xml) = @_;

        ...
    });

    my $cb = $transport->on_message;

=head1 METHODS

=head2 C<init>
    
    $transport->init;

(Re)initialize transport. Called automatically after new.

=head2 C<connect>
    
    $transport->connect;

Estiblish connection to jabber server.

=cut
