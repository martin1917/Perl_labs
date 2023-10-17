use 5.010;

print "write text: ";
$text = <STDIN>;

$file_path = "simple123.html";
open(my $fd, ">$file_path") or die "file error";

select $fd;
print<<HTML;
<html>
	<body>
		<h1>$text</h1>
	</body>
</html>
HTML

select STDOUT;
print "Text has written to $file_path. Check it";