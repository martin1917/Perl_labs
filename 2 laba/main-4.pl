use 5.010;

format menu = 
+----------------------------------+
|               Menu               |
+----------------------------------+
| 1. Add string to list            |
| 2. Delete string from list       |
| 3. Show list                     |
| 4. Exit                          |
+----------------------------------+
.

my $begin = "_";
my %list;
while (1) {
	$~ = menu;
	write;
	print "select action: ";
    my $choice = <STDIN>;
    chomp $choice;
	if ($choice == 1) {
        add_string();
    } elsif ($choice == 2) {
        delete_string();
    } elsif ($choice == 3) {
        view_list();
	} elsif ($choice == 4) {
		say "The end!!!";
        last;
    } else {
        say "Incorrect selection. Try again";
    }
}

sub add_string {
    print "write string for adding: ";
    my $value = <STDIN>;
    chomp $value;
	
	my $left = $begin;
	my $right = $list{$left};
	while ($right) {
		if (($value cmp $right) == 1) {
			$left = $right;
			$right = $list{$right};
			next;
		}
		
		my $is_first = ($left cmp $begin) == 0;
		my $left_less_value = ($left cmp $value) == -1;
		my $value_less_right = ($value cmp $right) == -1;		
		if (($is_first || $left_less_value) && $value_less_right) {
			$list{$left} = $value;
			$list{$value} = $right;
			last;
		}
	}
	
	unless ($right) {
		$list{$left} = $value;
		$list{$value} = undef;
	}
	
    say "string has added successful";
	say "\n========================================\n";
}

sub delete_string {
    print "write string for deleting: ";
    my $value = <STDIN>;
    chomp $value;
	
	my $cur = $begin;
	while ($cur && ($list{$cur} cmp $value) != 0) {
		$cur = $list{$cur};
	}
	
	my $left = $cur;
	my $right = $list{$left};	
	$list{$left} = $list{$right};
	delete $list{$right};
	
	say "\n========================================\n";
}

sub view_list {
    say "list of strings:";
	
	my $cur = $begin;
	while ($cur) {
		print "$cur -> ";
		$cur = $list{$cur};
	}
	
	say "\n========================================\n";
}