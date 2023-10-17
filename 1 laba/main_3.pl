use 5.010;

print "write text: ";
$text = <STDIN>;

$file_path = "simple.html";
open(my $fd, ">$file_path") or die "file error";

select $fd;
print "<html>";
print "<body>";
print "<h1>$text</h1>";
print "</body>";
print "</html>";
close $fd;

select STDOUT;
print "Text has written to $file_path. Check it";