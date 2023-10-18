use 5.010;

# вывод состояния каждого из стержней
sub info {
	my ($a, $b, $c) = @_;
	say "current state:";
	say "$a->{name}: " . join " -> ", @{$a->{disks}};
	say "$b->{name}: " . join " -> ", @{$b->{disks}};
	say "$c->{name}: " . join " -> ", @{$c->{disks}};
	print "\n";
}

# перемещение диска с одного стержня на другой
sub move {
	my ($from, $to) = @_;
	my $val = pop @{$from->{disks}};
	push @{$to->{disks}}, $val;
	say "Action: move disk of diameter $val from $from->{name} to $to->{name}";
};

sub hanoi {
	my ($a, $b, $c, $count) = @_;
	if ($count == 1) {
		move($a, $b);
		info($a, $b, $c);
	} else {
		hanoi($a, $c, $b, $count - 1);		
		move($a, $b);
		info($a, $b, $c);		
		hanoi($c, $b, $a, $count - 1);
	}
}

print "Write N: ";
my $n = <>;
chomp $n;

my $a = { name => "A", disks => [ reverse(1..$n) ] };
my $b = { name => "B", disks => [] };
my $c = { name => "C", disks => [] };

my $file_path = "hanoi_solution.txt";
open(my $file, ">$file_path") or die("File error\n");
select $file;

info($a, $c, $b);
hanoi($a, $b, $c, $n);

select STDOUT;
say "check solution in $file_path";