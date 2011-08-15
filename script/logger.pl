#!/usr/bin/env perl

use strict;
use warnings;

use FindBin '$Bin';
use lib "$Bin/lib/";

use FindBin '$Bin';

use AnyEvent;
use Class::Load 'load_class';

use JLogger;
use JLogger::Config;

my $cv = AnyEvent->condvar;

my $config = JLogger::Config->new->load_file("$Bin/../config.yaml");
my $logger = JLogger->new(%$config);

$logger->connect;

$cv->recv;
