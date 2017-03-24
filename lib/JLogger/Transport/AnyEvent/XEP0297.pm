package JLogger::Transport::AnyEvent::XEP0297;

use strict;
use warnings;

use base 'JLogger::Transport::AnyEvent';

sub _recv_stanza_xml {
    my ($self, $node, $stop) = @_;

    if ($node->eq('component' => 'message')) {
        my ($forwarded) =
          $node->find_all(['urn:xmpp:forward:0', 'forwarded']);

        $self->on_message->($self, $forwarded) if $forwarded;
        $$stop = 1;
    }
}


1;
