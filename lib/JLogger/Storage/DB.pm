package JLogger::Storage::DB;

use strict;
use warnings;

use base 'JLogger::Storage';
use DBI;

my %handlers = (message => \&_save_message);

sub init {
    my $self = shift;

    $self->{_dbh} =
      DBI->connect($self->{source}, $self->{username}, $self->{password},
        {RaiseError => 1, AutoCommit => 1, %{$self->{attr} || {}}});
}

sub store {
    my ($self, $message) = @_;

    if (my $handler = $handlers{$message->{type}}) {
        return $handler->($self, $message);
    }
    warn "Unknown type: $message->{type}\n";
}

sub _save_message {
    my ($self, $message) = @_;

    my $sql = <<'SQL';
INSERT
    INTO messages(sender, recipient, id, type, body, thread)
VALUES(?, ?, ?, ?, ?, ?)
SQL

    $self->{_dbh}
      ->do($sql, undef, @{$message}{qw/from to id message_type body thread/});
}

1;
__END__

=head1 NAME

JLogger::Storage::DB - store messages in database

=head1 SYNOPSIS

General config in C<config.yaml>
    storages:
        - JLogger::Storage::DB:
            source: <dbi storage string>
            username: <database username>
            password: <database password>
            attr: <additional connection parameters>

=head1 DESCRIPTION

Stores logged messages in a database. Before storing messages you need to load
schema. Schema files can be found in C<schema/> directory.

=head1 EXAMPLES

Sample configuration strings for C<config.xml> for different databases.

=head2 SQLite

    storages:
        - JLogger::Storage::DB:
            source: dbi:SQLite:jlogger.sql

=head2 MySQL

    storages:
        - JLogger::Storage::DB:
            source: dbi:mysql:database=jlogger
            username: mysql_username
            password: mysql_password

=head2 PostgreSQL

    storage:
        - JLogger::Storage::DB:
            source: dbi:Pg:dbname=jlogger
            username: pg_username
            password: pg_password

=cut
