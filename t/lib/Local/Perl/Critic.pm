# vim: ts=4 sts=4 sw=4 et: syntax=perl
#
# Copyright (c) 2019-2022 Sven Kirmess
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

use 5.006;
use strict;
use warnings;

package Local::Perl::Critic;

our $VERSION = '0.001';

use Local::Perl::Critic::Config;

use Class::Tiny 1 {
    config => sub { Local::Perl::Critic::Config->new; },
};

sub violation {
    my ( $self, $file, $violation ) = @_;

    if ( !exists $self->{_files}{$file} ) {
        $self->{_files}{$file} = [];
    }

    if ( defined $violation ) {
        push @{ $self->{_files}{$file} }, $violation;
    }

    return;
}

sub critique {
    my ( $self, $file ) = @_;

    die "File not found: $file\n" if !exists $self->{_files}{$file};

    return @{ $self->{_files}{$file} };
}

1;
