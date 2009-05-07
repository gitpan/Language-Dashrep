use inc::Module::Install;

name     'Language-Dashrep';
all_from 'lib/Language/Dashrep.pm';
author   'Richard Fobes <fobes@CPAN.org>';

build_requires 'Test::More';

auto_install;

WriteAll;

