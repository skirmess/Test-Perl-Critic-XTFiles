#!perl

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

use Test::Fatal;
use Test::More 0.88;

use FindBin qw($RealBin);
use lib "$RealBin/lib";

use Local::Perl::Critic;

my $obj = Local::Perl::Critic->new;
isa_ok( $obj, 'Local::Perl::Critic', 'new returns' );

my $c = $obj->config;
isa_ok( $c, 'Local::Perl::Critic::Config', 'config returns' );
is( $c->verbose,    4, 'verbose defaults to 4' );
is( $c->verbose(5), 5, 'verbose can be set to 5' );
is( $c->verbose,    5, '... and is now 5' );

is( exception { $obj->critique('file.pl') }, "File not found: file.pl\n", 'critique throws an exception if a file is not configured' );

is( $obj->violation('file.txt'), undef, 'configuring a file without violations' );
is_deeply( [ $obj->critique('file.txt') ], [], '... file no longer throws an exception' );

is( $obj->violation( 'file.txt', 'hello world' ), undef, 'configuring a file with a violation' );
is_deeply( [ $obj->critique('file.txt') ], ['hello world'], '... violation is reported' );

is( $obj->violation( 'file.txt', 'second_violation' ), undef, 'configuring a file with a second violation' );
is_deeply( [ $obj->critique('file.txt') ], [ 'hello world', 'second_violation' ], '... violations are reported' );

done_testing;
