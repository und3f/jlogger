use inc::Module::Install;

name 'JLogger';

all_from 'lib/JLogger.pm';

requires 'AnyEvent::XMPP';
requires 'Class::Load';
requires 'YAML';
requires 'DBI';

test_requires 'DBD::SQLite';

WriteAll;
