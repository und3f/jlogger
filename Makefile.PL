use inc::Module::Install;

name 'JLogger';

all_from 'lib/JLogger.pm';

requires 'AnyEvent::XMPP';
requires 'Class::Load';

WriteAll;
