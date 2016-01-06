package JLogger::Filter::pass;

use strict;
use warnings;

use base 'JLogger::Filter';

sub filter {
    my ($self, $message) = @_;

    0;
}

1;
