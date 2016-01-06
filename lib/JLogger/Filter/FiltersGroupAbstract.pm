package JLogger::Filter::FiltersGroupAbstract;

use strict;
use warnings;
use Class::Load 'load_class';

use base 'JLogger::Filter';

sub new {
    my ($class, %atrs) = @_;

    my $filters = [];
    foreach my $filter (@{delete $atrs{filters}}) {
        my ($fclass, $args_ref) = @$filter;
        load_class $fclass;

        my @args = $class->deref_args($args_ref);
        push @$filters, $fclass->new(@args);
    }

    $class->SUPER::new(%atrs, filters => $filters);
}

sub deref_args {
    my ($class, $args_ref) = @_;

    my $ref  = ref $args_ref;
    if ($ref eq 'ARRAY') {
        return @$args_ref;
    }
    elsif ($ref eq 'HASH') {
        return %$args_ref;
    }
    elsif (not defined $args_ref) {
        return;
    }

    return $args_ref;
}

1;
