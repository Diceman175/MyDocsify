#!/usr/bin/perl
# ============================================================
# Title: Your Perl Script
# Purpose: A brief description of what this script does
# ============================================================
#
# METADATA:
#   filename: your-script.pl
#   title: Your Perl Script
#   authorname: Your Name
#   version: 2026-04-21
#   created: 2026-04-20
#   last_updated: 2026-04-21
#
# CHANGELOG:
#   Version 2026-04-21 - Your Name
#     OPS: Include rules-change-codes files and update metadata
#   Version 2026-04-21 - Your Name
#     CHG: Clean 1.0.2 baseline snapshot
#   Most recent entries first. Reference change codes from
#   rules-change-codes.jsonc for semantic versioning.
#
#   Version 0.1.0 - 2026-04-20 - Your Name
#     IMP: Initial Perl script setup with metadata template
#
# CHANGE CODES:
#   Reference: rules-change-codes.jsonc
#
#   FIX  - Bug fixes (patch bump)
#   IMP  - New features (minor bump)
#   CHG  - Improvements/refactoring (minor bump)
#   REF  - Documentation/references (patch bump)
#   BRK  - Breaking changes (major bump)
#   SEC  - Security fixes (patch bump)
#   TST  - Tests/CI (patch bump)
#   DOC  - Documentation (patch bump)
#   CFG  - Configuration (minor bump)
#   DEP  - Dependencies (patch bump)
#   OPS  - Operations/deployment (patch bump)
#   WIP  - Work in progress (no version bump)
#
# USAGE:
#   perl your-script.pl [options]
#   perl your-script.pl --key "example-key"
#   perl your-script.pl --help
#
# NOTES:
#   Requires: Getopt::Long (core), Carp (core)
#   For full code definitions, see rules-change-codes.jsonc
# ============================================================

use strict;
use warnings;
use utf8;
use open qw(:std :utf8);

use Getopt::Long qw(GetOptions);
use Carp         qw(croak confess);
use File::Spec;
use POSIX        qw(strftime);

# ============================================================
# Constants
# ============================================================

use constant {
    VERSION   => '0.1.0',
    SCRIPT    => 'your-script.pl',
    EXIT_OK   => 0,
    EXIT_FAIL => 1,
};

# ============================================================
# Argument Parsing
# ============================================================

my %opts = (
    key     => 'default-key',
    verbose => 0,
    help    => 0,
);

GetOptions(
    'key=s'   => \$opts{key},
    'verbose' => \$opts{verbose},
    'help'    => \$opts{help},
) or die usage();

if ($opts{help}) {
    print usage();
    exit EXIT_OK;
}

# ============================================================
# Entry Point
# ============================================================

main();

sub main {
    my $result = get_example_data($opts{key});
    print "$result\n";
    return EXIT_OK;
}

# ============================================================
# Functions
# ============================================================

sub get_example_data {
    my ($key) = @_;
    croak 'key is required' unless defined $key && $key ne '';

    my $timestamp = strftime('%Y-%m-%dT%H:%M:%S', localtime);
    return "Data for key: $key (at $timestamp)";
}

sub log_verbose {
    my ($msg) = @_;
    return unless $opts{verbose};
    print STDERR "[verbose] $msg\n";
}

sub usage {
    return <<END_USAGE;
Usage: perl @{[SCRIPT]} [options]

Options:
  --key <string>   Key to look up (default: default-key)
  --verbose        Enable verbose output
  --help           Show this help message

Version: @{[VERSION]}
END_USAGE
}

# ============================================================
# END
# ============================================================

__END__

=pod

=head1 NAME

your-script.pl - Your Perl Script

=head1 SYNOPSIS

  perl your-script.pl --key "example-key"

=head1 DESCRIPTION

A brief description of what this script does.

=head1 OPTIONS

=over 4

=item B<--key> I<string>

The key to look up (default: default-key).

=item B<--verbose>

Print additional diagnostic output to STDERR.

=item B<--help>

Display usage information.

=back

=head1 VERSION

0.1.0

=head1 AUTHOR

Your Name

=cut
