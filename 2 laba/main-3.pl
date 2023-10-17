use 5.010;

# заполнение массива из консоли
# до тех пор пока не будет введен ENTER
sub fill_arr {
	my $ref_arr = $_[0];
	while($line = <STDIN>) {
		chomp($line);
		last if ($line =~ /^\s*$/);
		push(@$ref_arr, $line);
	}
}

my @arr1;
say("fill first array");
&fill_arr(\@arr1);

my @arr2;
say("fill second array");
&fill_arr(\@arr2);

my $index = 0;
for $x (@arr1) {
	$res[$index] = $x;
	$index += 2;
}

my $index = 1;
for $x (@arr2) {
	$res[$index] = $x;
	$index += 2;
}

say join ", ", @res;
say scalar @res;