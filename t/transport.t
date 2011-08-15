#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 3;

use_ok 'JLogger::Transport';

my $transport = new_ok 'JLogger::Transport',
  [host => '127.0.0.1', port => '5520', secret => 'secret'];

can_ok $transport, qw/host port secret on_message connect disconnect/;
