package JLogger::Filter::FieldEq;

use strict;
use warnings;

use base 'JLogger::Filter';

sub filter {
    my ($self, $message) = @_;

    foreach my $key (keys %{$self->{fields}}) {
        my $value = $self->{fields}->{$key};
        if (exists $message->{$key} && $message->{$key} eq $value) {
            return 0;
        }
    }

    1;
}

1;
