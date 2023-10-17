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

# удаление повторов
sub get_unique {
	my ($arr) = @_;
	my %arr_hash = map { $_ => 1 } @$arr;
	my @set = keys %arr_hash;
	return @set;
}

# объединение
sub get_union {
	my ($arr1, $arr2) = @_;
	my @res = (@$arr1, @$arr2);
	return get_unique(\@res);
}

# пересечение
sub get_intersection {
	my ($arr1, $arr2) = @_;
	
	my @res;
	for $a (@$arr1) {
		my $find = grep { $a == $_ } @$arr2;
		if ($find) {
			push @res, $a;
		}
	}
	
	return @res;
}

# разность
sub get_diff {
	my ($arr1, $arr2) = @_;
	
	my @res;
	for $a (@$arr1) {
		my $find = grep { $a == $_ } @$arr2;
		unless ($find) {
			push @res, $a;
		}
	}
	
	return @res;
}

my @arr1;
say("fill first array");
&fill_arr(\@arr1);

my @arr2;
say("fill second array");
&fill_arr(\@arr2);

my @set1 = get_unique(\@arr1);
my @set2 = get_unique(\@arr2);

my @union = get_union(\@set1, \@set2);
my @intersection = get_intersection(\@set1, \@set2);
my @difference1 = get_diff(\@set1, \@set2);
my @difference2 = get_diff(\@set2, \@set1);
my @symmetric_difference = get_union(\@difference1, \@difference2);

say("arr1 = " . join(", ", @arr1));
say("arr2 = " . join(", ", @arr2));
say("union = " . join(", ", @union));
say("intersection = " . join(", ", @intersection));
say("arr1 \\ arr2 = " . join(", ", @difference1));
say("arr2 \\ arr1 = " . join(", ", @difference2));
say("arr1 /_\\ arr2 = " . join(", ", @symmetric_difference));