package Git::Code::Review::Notify::STDOUT;
# ABSTRACT: Notification plugin that outputs the message to STDOUT
use CLI::Helpers qw(:output);

sub send {
    shift @_ if ref $_[0] || $_[0] eq __PACKAGE__;
    my %config = @_;
    output({data=>1}, $config{message});
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Git::Code::Review::Notify::STDOUT - Notification plugin that outputs the message to STDOUT

=head1 VERSION

version 1.0

=head1 AUTHOR

Brad Lhotsky <brad@divisionbyzero.net>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2014 by Brad Lhotsky.

This is free software, licensed under:

  The (three-clause) BSD License

=cut
