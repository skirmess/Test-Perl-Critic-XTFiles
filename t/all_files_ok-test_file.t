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

use Test::Builder::Tester;
use Test::MockModule 0.14;
use Test::More 0.88;

use Perl::Critic::Violation;

use FindBin qw($RealBin);
use lib "$RealBin/lib";

use Local::Perl::Critic;

use Test::Perl::Critic::XTFiles;

use constant CLASS => 'Test::Perl::Critic::XTFiles';

chdir 'corpus/dist4' or die "chdir failed: $!";

note('successful Perl::Critic');
{

    my $done_testing = 0;
    my $skip_all     = 0;
    my @skip_all_args;
    my $module = Test::MockModule->new('Test::Builder');
    $module->redefine( 'done_testing', sub { $done_testing++; return; } );
    $module->redefine( 'skip_all', sub { @skip_all_args = @_; $skip_all++; return; } );

    my $obj = CLASS()->new;

    my $pc = Local::Perl::Critic->new;
    $pc->violation('t/hello.t');

    $obj->critic( Local::Perl::Critic->new );
    $obj->critic_test($pc);

    test_out('ok 1 - Perl::Critic for "t/hello.t"');
    my $rc = $obj->all_files_ok;
    test_test('correct test output');

    is( $rc, 1, 'all_files_ok returned 1' );

    is( $done_testing, 1, '... done_testing was called once' );
    is( $skip_all,     0, '... skip_all was not called' );
}

#
done_testing();

exit 0;
