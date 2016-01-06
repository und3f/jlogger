package JLogger::Filter::and;

use strict;
use warnings;
use Class::Load 'load_class';

use base 'JLogger::Filter::FiltersGroupAbstract';

sub filter {
    my ($self, $message) = @_;

    foreach my $filter (@{$self->{filters}}) {
        return 1 if $filter->filter($message);
    }

    return;
}

1;
