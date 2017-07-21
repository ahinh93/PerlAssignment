#!/usr/bin/perl
 
use DBI;
use strict;
 
# define database name and driver
my $driver   = "SQLite";
my $db_name = "sample.db";
my $dbd = "DBI:$driver:dbname=$db_name";
 
# sqlite does not have a notion of username/password
my $username = "";
my $password = "";
 
# create and connect to a database.
# this will create a file named sample.db
my $dbh = DBI->connect($dbd, $username, $password, { RaiseError => 1 })
                      or die $DBI::errstr;
print STDERR "Database opened successfully\n";


# create a table
my $stmt = qq(CREATE TABLE IF NOT EXISTS USERS
             (first_name CHAR(50),
              last_name CHAR(50),
              home CHAR(50)););
my $ret = $dbh->do($stmt);

if($ret < 0) {
   print STDERR $DBI::errstr;
} else {
   print STDERR "Table created successfully\n";
}



# insert eight rows into the table
$stmt = qq(INSERT INTO USERS (first_name,last_name,home)
           VALUES ('Rose', 'Tyler', 'Earth'));
$ret = $dbh->do($stmt) or die $DBI::errstr;
 
$stmt = qq(INSERT INTO USERS (first_name,last_name,home)
           VALUES ('Zoe', 'Heriot', 'Space Station W3'));
$ret = $dbh->do($stmt) or die $DBI::errstr;
 
$stmt = qq(INSERT INTO USERS (first_name,last_name,home)
           VALUES ('Jo', 'Grant', 'Earth'););
$ret = $dbh->do($stmt) or die $DBI::errstr;
 
$stmt = qq(INSERT INTO USERS (first_name,last_name,home)
           VALUES ('Leela', NULL, 'Unspecified'));
$ret = $dbh->do($stmt) or die $DBI::errstr;
 
$stmt = qq(INSERT INTO USERS (first_name,last_name,home)
           VALUES ('Romana', NULL, 'Gallifrey'));
$ret = $dbh->do($stmt) or die $DBI::errstr;
 
$stmt = qq(INSERT INTO USERS (first_name,last_name,home)
           VALUES ('Clara', 'Oswald', 'Earth'));
$ret = $dbh->do($stmt) or die $DBI::errstr;
 
$stmt = qq(INSERT INTO USERS (first_name,last_name,home)
           VALUES ('Adric', NULL, 'Alzarius'));
$ret = $dbh->do($stmt) or die $DBI::errstr;
 
$stmt = qq(INSERT INTO USERS (first_name,last_name,home)
           VALUES ('Susan', 'Foreman', 'Gallifrey'));
$ret = $dbh->do($stmt) or die $DBI::errstr;
 

#select the contents of the table and prints it
$stmt = qq(SELECT first_name, last_name, home from USERS;);
my $obj = $dbh->prepare($stmt);
$ret = $obj->execute() or die $DBI::errstr;

if($ret < 0){
	print STDERR $DBI::errstr;
}
while(my @row = $obj->fetchrow_array()){
	print "FIRST_NAME: ". $row[0] . "\n";
	print "LAST_NAME: ". $row[1] . "\n";
	print "HOME:  ". $row[2] ."\n\n";

}
# delete the users table
=begin comment
$stmt = qq(DROP TABLE USERS);
$ret = $dbh->do($stmt) or die $DBI::errstr;

if($ret < 0) {
   print STDERR $DBI::errstr;
} else {
   print STDERR "A total of $ret rows deleted\n";
}
=cut
#close the connection to the database
$dbh->disconnect();
print STDERR "Exit the database\n";