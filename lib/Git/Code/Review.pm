# ABSTRACT: Tools for performing code review using Git as the backend
package Git::Code::Review;
use strict;
use warnings;

our $VERSION = '0.5'; # VERSION

use App::Cmd::Setup -app;

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Git::Code::Review - Tools for performing code review using Git as the backend

=head1 VERSION

version 0.5

=head1 SYNOPSIS

This module installs a new command to allow you to perform a tracked code review
using a git repository as the storage and communication medium for the audit.

This is intended to be used as a B<post-commit> code review tool.

=head1 INSTALL

Recommended install with L<CPAN Minus|http://cpanmin.us>:

    cpanm Git::Code::Review

You can also use CPAN:

    cpan Git::Code::Review

This will take care of ensuring all the dependencies are satisfied and will install the scripts into the same
directory as your Perl executable.

=head2 USAGE

The utility ships with documentation.

    git-code-review help

And each command has a basic overview of it's own options and uses.

    git-code-review help init
    git-code-review help select
    git-code-review help profile
    git-code-review help list
    git-code-review help pick
    git-code-review help comment
    git-code-review help fixed

=head2 SEE ALSO

    perldoc Git::Code::Review::Tutorial

=head1 AUTHOR

Brad Lhotsky <brad@divisionbyzero.net>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2014 by Brad Lhotsky.

This is free software, licensed under:

  The (three-clause) BSD License

=cut
