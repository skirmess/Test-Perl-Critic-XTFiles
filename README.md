# NAME

Test::Perl::Critic::XTFiles - Perl::Critic test with XT::Files interface

# VERSION

Version 0.001

# SYNOPSIS

    use Test::Perl::Critic::XTFiles;
    Test::Perl::Critic::XTFiles->new->all_files_ok;

    use Perl::Critic;
    use Test::Perl::Critic::XTFiles;
    Test::Perl::Critic::XTFiles->new(
        critic => Perl::Critic->new( -profile => 'xt/author/perlcritic.rc' ),
    )->all_files_ok;

# DESCRIPTION

Tests all the files supplied from [XT::Files](https://metacpan.org/pod/XT::Files) with [Perl::Critic](https://metacpan.org/pod/Perl::Critic). The
output, and behavior, should be the same as from [Test::Perl::Critic](https://metacpan.org/pod/Test::Perl::Critic).

# USAGE

## new( \[ ARGS \] )

Returns a new `Test::Perl::Critic::XTFiles` instance. `new` takes an
optional hash or list with its arguments.

    Test::Perl::Critic::XTFiles->new(
        critic => Perl::Critic->new( -profile => '.perltidyrc' ),
        critic_test => Perl::Critic->new( -profile => '.perltidyrc-tests' ),
    );

The following arguments are supported:

### critic, critic\_module, critic\_script, critic\_test (optional)

Sets the default [Perl::Critic](https://metacpan.org/pod/Perl::Critic) object and the objects used to test
module, script or test files. See the method with the same name for further
explanation.

## all\_file\_ok

Calls the `files` method of [Test::XTFiles](https://metacpan.org/pod/Test::XTFiles) to get all the files to
be tested. All files are tested with the [Perl::Critic](https://metacpan.org/pod/Perl::Critic) object configured
for their type.

It calls `done_testing` or `skip_all` so you can't have already called
`plan`.

`all_files_ok` returns something _true_ if all files test ok and _false_
otherwise.

Please see [XT::Files](https://metacpan.org/pod/XT::Files) for how to configure the files to be checked.

## critic

Returns, and optionally sets, the [Perl::Critic](https://metacpan.org/pod/Perl::Critic) default object. This is
only used to initialize the other `critic_*` methods. On first access this
is initialized to `Perl::Critic-`new()>.

## critic\_module( \[ARGS\] )

Returns, and optionally sets, the [Perl::Critic](https://metacpan.org/pod/Perl::Critic) object used to test module
files. On first access this is initialized to `$self-`critic()>.

## critic\_script( \[ARGS\] )

Returns, and optionally sets, the [Perl::Critic](https://metacpan.org/pod/Perl::Critic) object used to test script
files. On first access this is initialized to `$self-`critic()>.

## critic\_test( \[ARGS\] )

Returns, and optionally sets, the [Perl::Critic](https://metacpan.org/pod/Perl::Critic) object used to test test
files. On first access this is initialized to `$self-`critic()>.

# EXAMPLES

## Example 1 Default usage

Check all the files returned by [XT::Files](https://metacpan.org/pod/XT::Files) with [Perl::Critic](https://metacpan.org/pod/Perl::Critic).

    use 5.006;
    use strict;
    use warnings;

    use Test::Perl::Critic::XTFiles;

    Test::Perl::Critic::XTFiles->new->all_files_ok;

## Example 2 Check non-default directories or files

Use the same test file as in Example 1 and create a `.xtfilesrc` config
file in the root directory of your distribution.

    [Dirs]
    module = lib
    module = tools
    module = corpus/hello

    [Files]
    module = corpus/world.pm

## Example 3 Use a different Perl::Critic config file for script files

    use 5.006;
    use strict;
    use warnings;

    use Perl::Critic;
    use Test::Perl::Critic::XTFiles;

    Test::Perl::Critic::XTFiles->new(
        critic_script => Perl::Critic->new( -profile => '.perlcriticrc-scripts' ),
    )->all_files_ok;

# SEE ALSO

[Test::More](https://metacpan.org/pod/Test::More), [Perl::Critic](https://metacpan.org/pod/Perl::Critic), [XT::Files](https://metacpan.org/pod/XT::Files)

# SUPPORT

## Bugs / Feature Requests

Please report any bugs or feature requests through the issue tracker
at [https://github.com/skirmess/Test-Perl-Critic-XTFiles/issues](https://github.com/skirmess/Test-Perl-Critic-XTFiles/issues).
You will be notified automatically of any progress on your issue.

## Source Code

This is open source software. The code repository is available for
public review and contribution under the terms of the license.

[https://github.com/skirmess/Test-Perl-Critic-XTFiles](https://github.com/skirmess/Test-Perl-Critic-XTFiles)

    git clone https://github.com/skirmess/Test-Perl-Critic-XTFiles.git

# AUTHOR

Sven Kirmess <sven.kirmess@kzone.ch>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2019 by Sven Kirmess.

This is free software, licensed under:

    The (two-clause) FreeBSD License
