package JLogger::Filter::true;

use strict;
use warnings;

use base 'JLogger::Filter';

sub filter {
    my ($self, $message) = @_;

    1;
}

1;
