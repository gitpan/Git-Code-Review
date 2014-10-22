# ABSTRACT: Quick overview of the Audit Directory
package Git::Code::Review::Command::list;
use strict;
use warnings;

use CLI::Helpers qw(:all);
use Git::Code::Review::Utilities qw(:all);
use Git::Code::Review -command;
use File::Basename;
use File::Spec;

sub opt_spec {
    return (
        ['state=s',    "CSV of states to show."],
    );
}

sub description {
    my $DESC = <<"    EOH";

    This command can be used to view the status of the audit.
    EOH
    $DESC =~ s/^[ ]{4}//mg;
    return $DESC;
}

sub execute {
    my($cmd,$opt,$args) = @_;

    my %SHOW = map { $_ => 1 } split /,|\s+/, $opt->{state};
    my $audit = gcr_repo();
    gcr_reset();

    my @list = grep /\.patch$/, $audit->run('ls-files');
    if( @list ) {
        my %info = ();
        my @commits = map { $_=gcr_commit_info( basename $_ ) } @list;
        output({color=>'cyan'}, sprintf "-[ Commits in the Audit %s:: %s ]-",
            scalar(keys %SHOW) ? '(' . join(',', sort keys %SHOW) . ') ' : '',
            gcr_origin('audit')
        );
        # Assemble Comments
        my %comments = ();
        foreach my $comment ($audit->run('ls-files', qq{*/Comments/*})) {
            my @path = File::Spec->splitdir($comment);
            $comments{$path[-2]} ||= 0;
            $comments{$path[-2]}++;
        }
        # Assemble Commits
        foreach my $commit ( sort { $a->{date} cmp $b->{date} } @commits ) {
            $commit->{state} = 'resigned' unless gcr_not_resigned($commit->{base});
            $info{$commit->{state}} ||= 0;
            $info{$commit->{state}}++;
            next if keys %SHOW && !exists $SHOW{$commit->{state}};
            my $color = gcr_state_color($commit->{state});
            output({indent=>1,color=>$color}, join("\t",
                    $commit->{state}, $commit->{date}, $commit->{sha1}, $commit->{author},
                    exists $comments{$commit->{sha1}} ? "(comments:$comments{$commit->{sha1}})" : "",
                )
            );
        }
        output({color=>'cyan'}, sprintf "-[ Status %s from %s ]-",
            join(', ', map { "$_:$info{$_}" } sort keys %info),
            gcr_origin('source')
        );
    }
    else {
        output({color=>'green'}, "No commits flagged with concerns!");
    }
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Git::Code::Review::Command::list - Quick overview of the Audit Directory

=head1 VERSION

version 0.1

=head1 AUTHOR

Brad Lhotsky <brad@divisionbyzero.net>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2014 by Brad Lhotsky.

This is free software, licensed under:

  The (three-clause) BSD License

=cut
