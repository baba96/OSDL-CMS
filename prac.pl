#!/usr/bin/perl -w

use DBI;
use DBD::mysql;
use CGI qw(:standard);

use warnings;

open(ACCESS_INFO, "<..\/accessDB") || die "Can't access login credentials";

my $database = <ACCESS_INFO>;
my $host = <ACCESS_INFO>;
my $userid = <ACCESS_INFO>;
my $passwd = <ACCESS_INFO>;

chomp ($database, $host, $userid, $passwd);

close(ACCESS_INFO);
# print the header
print header;

print "<table border=\"1\" width=\"800\"> \n";

print "<tr><td>First</td><td>Last</td><td>Address 1</td><td>Address 2</td><td>City</td><td>State</td><td>Postal Code</td></tr>\n";

$connection = ConnectToMySql($database);

$query = "select name_first, name_last, address_01, address_02, address_city, address_state, address_postal_code from address";

$statement = $connection->prepare($query);
$statement->execute();

while (@data = $statement->fetchrow_array()) {
$name_first = $data[0];
$name_last = $data[1];
$address_01 = $data[2];
$address_02 = $data[3];
$address_city = $data[4];
$address_state = $data[5];
$address_postal_code = $data[6];

print "<tr><td>$name_first</td><td>$name_last</td><td>$address_01</td><td>$address_02</td><td>$address_city</td><td>$address_state</td><td>$address_postal_code</td></tr>\n";

}

print "</table>\n";

exit;

#--- start sub-routine ------------------------------------------------
sub ConnectToMySql {
#----------------------------------------------------------------------

my ($db) = @_;

# assign the values to your connection variable
my $connectionInfo="dbi:mysql:$db;$host";
# make connection to database
my $l_connection = DBI->connect($connectionInfo,$userid,$passwd);

# the value of this connection is returned by the sub-routine
return $l_connection;

}

#--- end sub-routine --------------------------------------------------
