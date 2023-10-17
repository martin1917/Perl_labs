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

my @arr;
say("fill array");
&fill_arr(\@arr);

say join ", ", @arr;

my $count = int(scalar(@arr) / 2);
for(my $i = 0; $i < $count; $i += 1) {
	my ($left, $right) = (2 * $i, 2 * $i + 1);
	@arr[$left, $right] = @arr[$right, $left];
}

say join ", ", @arr;