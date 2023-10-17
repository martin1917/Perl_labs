use 5.010;

print "write your name: ";
$name = <STDIN>;
print "write your age: ";
$age = <STDIN>;

$~ = SALUT_FORMAT;
$^ = SALUT_FORMAT_TOP;
$= = 1;
write;

format SALUT_FORMAT_TOP =
***************my header***************
.

format SALUT_FORMAT =
Congratulations to you, ^>>>>>>>>>>>>>>>>>>>>>>!
$name
Today, at the age of @##.##
$age
You have written your first Perl-program
.