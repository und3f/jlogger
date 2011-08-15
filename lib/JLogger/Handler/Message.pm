package JLogger::Handler::Message;

use strict;
use warnings;

use base 'JLogger::Handler';

sub handle {
    my ($self, $node) = @_;

    my $message = {
        from => $node->attr('from'),
        to   => $node->attr('to'),
        type => 'message',

        id   => $node->attr('id'),
        message_type => $node->attr('type'),
        body => ($node->find_all(['component' => 'body']))[0]->text,
    };
}

1;
