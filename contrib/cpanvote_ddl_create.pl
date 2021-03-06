#!/usr/bin/perl

use strict;
use warnings;

use Pod::Usage;
use Getopt::Long;
use cpanvote::Schema;

my ( $help );
GetOptions(
    'p|preversion:s' => \my $preversion,
    'dsn'            => \my $dsn,
    'user'           => \my $user,
    'password'       => \my $password,
) or die pod2usage;

my $schema  = cpanvote::Schema->connect( $dsn, $user, $password, );
my $sql_dir = './sql';
my $version = $schema->schema_version;
$schema->create_ddl_dir( 'MySQL',  $version, $sql_dir, $preversion );
$schema->create_ddl_dir( 'SQLite', $version, $sql_dir, $preversion );
