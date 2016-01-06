package JLogger::Filter::FiltersGroupAbstract;

use strict;
use warnings;
use Class::Load 'load_class';

use base 'JLogger::Filter';

sub new {
    my ($class, %atrs) = @_;

    my $filters = [];
    foreach my $filter (@{delete $atrs{filters}}) {
        my ($class, $args_ref) = @$filter;
        load_class $class;

        my @args = $args_ref;
        if (ref $args_ref eq 'ARRAY') {
            @args = @$args_ref;
        } elsif (ref $args_ref eq 'HASH') {
            @args = %$args_ref;
        }

        push @$filters, $class->new(@args);
    }

    $class->SUPER::new(%atrs, filters => $filters);
}

1;
