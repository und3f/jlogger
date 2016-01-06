#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

use_ok 'JLogger::Filter::pass';
use_ok 'JLogger::Filter::not';
use_ok 'JLogger::Filter::and';
use_ok 'JLogger::Filter::or';

my $filter_true = new_ok 'JLogger::Filter::pass';
ok !$filter_true->filter({from => 'bar@foo.com'});

my $filter_not = new_ok 'JLogger::Filter::not',
    ['JLogger::Filter::pass'];
ok $filter_not->filter({from => 'bar@foo.com'});

my $filter_not_not = new_ok 'JLogger::Filter::not',
    ['JLogger::Filter::not' => ['JLogger::Filter::pass']];
ok !$filter_not_not->filter({from => 'bar@foo.com'});

my $filter_and = new_ok 'JLogger::Filter::and',
    [
        filters => [
            ['JLogger::Filter::FieldRegexp' => {fields => { from => '^bar@*'}}],
            ['JLogger::Filter::Duplicate'],
        ],
    ];

my %message = (type => 'message', id => 1);
ok !$filter_and->filter({from => 'bar@foo.com', to => 'baz@foo.com', %message});
ok $filter_and->filter({from => 'bar@foo.com', to => 'baz@foo.com', %message});
ok $filter_and->filter({from => 'baz@foo.com', to => 'baz@foo.com', %message});

my $filter_or = new_ok 'JLogger::Filter::or',
    [
        filters => [
            ['JLogger::Filter::FieldRegexp' => {fields => { from => '^bar@*'}}],
            ['JLogger::Filter::FieldRegexp' => {fields => { from => '^otherbar@*'}}],
        ],
    ];

ok !$filter_or->filter({from => 'bar@foo.com', to => 'baz@foo.com', %message});
ok !$filter_or->filter({from => 'otherbar@foo.com', to => 'baz@foo.com', %message});
ok $filter_or->filter({from => 'baz@foo.com', to => 'baz@foo.com', %message});

done_testing;
