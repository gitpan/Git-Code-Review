# ABSTRACT: Quick overview of the Audit
package Git::Code::Review::Command::info;
use strict;
use warnings;

use CLI::Helpers qw(:all);
use Git::Code::Review::Utilities qw(:all);
use Git::Code::Review -command;
use YAML;

sub opt_spec {
    return (
    #       ['state=s',    "CSV of states to show."],
    );
}

sub description {
    my $DESC = <<"    EOH";

    Display information about the Git::Code::Review objects.
    EOH
    $DESC =~ s/^[ ]{4}//mg;
    return $DESC;
}

sub execute {
    my($cmd,$opt,$args) = @_;

    die "Not initialized, run git-code-review init!" unless gcr_is_initialized();

    my %config = gcr_config();
    foreach my $s (qw(source audit)) {
        no warnings;
        $config{origin}->{$s} = gcr_origin($s);
    }

    $config{profiles} = gcr_profiles();

    my $profile = gcr_profile();
    output({color=>'cyan'},"Git::Code::Review Config for (profile:$profile):");
    output(Dump \%config);
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Git::Code::Review::Command::info - Quick overview of the Audit

=head1 VERSION

version 0.9

=head1 AUTHOR

Brad Lhotsky <brad@divisionbyzero.net>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2014 by Brad Lhotsky.

This is free software, licensed under:

  The (three-clause) BSD License

=cut
