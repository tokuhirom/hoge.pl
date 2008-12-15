#!/usr/bin/perl
# =========================================================================
# detect high load process and logging to syslog
#
# =========================================================================
use strict;
use warnings;
use Sys::Syslog;

my $CPUTIME_LIMIT = 0;
my $MEMORY_LIMIT  = 6;

&main;exit;

sub main {
    openlog $0, 'cons,pid', 'local6';
    &cputime;
    &memp;
    closelog;
}

sub cputime {
    my $x = `ps ax --format "cputime,command"|sort -n|grep mf|grep -v grep`;
    for (split /\n/, $x) {
        syslog 'info', $_ if /^0*(\d+?):/ && $1 > $CPUTIME_LIMIT;
    }
}

sub memp {
    my $x = `ps ax --format "\%mem,command"|sort -n|grep mf| grep -v grep`;
    for (split /\n/, $x) {
        syslog 'info', $_ if /^\s*(\d+\.\d+)/ && $1 > $MEMORY_LIMIT;
    }
}
