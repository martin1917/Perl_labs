use 5.010;

say "write date in format 'dd.mm.yyyy'";
print "date: ";
chomp($date_str = <STDIN>);

$theme = "General structure of the program. Input and output of information.Formats";
$students = "Levin 20VP1";
$temp = 36.6;

$~ = CUSTOM_FORMAT;
$^ = CUSTOM_FORMAT_TOP;
$= = 2;
write;

format CUSTOM_FORMAT_TOP =
+=================================================================+
|                    CUSTOM HEADER                                |
+=================================================================+
.

format CUSTOM_FORMAT =
|Theme    | ^||||||||||||||||||||||||||||||||||||||||||| | center |
$theme
|         | ^||||||||||||||||||||||||||||||||||||||||||| |        |
$theme
+-----------------------------------------------------------------+
|Students | ^>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> | left   |
$students
+-----------------------------------------------------------------+
|Date     | ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< | right  |
$date_str
+-----------------------------------------------------------------+
Temp @##.## C
$temp
.