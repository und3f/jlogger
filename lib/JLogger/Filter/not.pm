package JLogger::Filter::not;

use strict;
use warnings;

use Class::Load 'load_class';
use JLogger::Filter::FiltersGroupAbstract;
use base 'JLogger::Filter';

sub new {
    my ($class, @atrs) = @_;

    my $fclass = shift @atrs;
    load_class $fclass;

    my @args = JLogger::Filter::FiltersGroupAbstract->deref_args(shift @atrs);
    $class->SUPER::new(@atrs, filter => $fclass->new(@args));
}

sub filter {
    my ($self, $message) = @_;

    not $self->{filter}->filter($message);
}

1;
