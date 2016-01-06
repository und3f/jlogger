package JLogger::Filter::or;

use strict;
use warnings;

use base 'JLogger::Filter::FiltersGroupAbstract';

sub filter {
    my ($self, $message) = @_;

    foreach my $filter (@{$self->{filters}}) {
        return 0 unless $filter->filter($message);
    }

    return 1;
}

1;
