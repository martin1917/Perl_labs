use 5.010;

sub add {
	my ($tree, $value) = @_;
	unless ($tree) {
		$_[0] = {
			VALUE => $value,
			LEFT => undef,
			RIGHT => undef
		};
		return;
	} 
	
	if ($value < $tree->{VALUE}) {
		unless ($tree->{LEFT}) {
			$tree->{LEFT} = {
				VALUE => $value,
				LEFT => undef,
				RIGHT => undef
			};
		} else {
			add($tree->{LEFT}, $value);
		}
	} else {
		unless ($tree->{RIGHT}) {
			$tree->{RIGHT} = {
				VALUE => $value,
				LEFT => undef,
				RIGHT => undef
			};
		} else {
			add($tree->{RIGHT}, $value);
		}
	}
}

sub find_min {
	my ($tree) = @_;
	unless ($tree->{LEFT}) {
		return $tree;
	}
	return find_min($tree->{LEFT});
}

sub remove {
	my ($tree, $value) = @_;
	unless ($tree) { return; }	
	if ($value == $tree->{VALUE}) {
		if (not(defined($tree->{LEFT})) && not(defined($tree->{RIGHT}))) {
			return undef;
		}
		
		unless ($tree->{LEFT}) {
			return $tree->{RIGHT};
		}
		
		unless ($tree->{RIGHT}) {
			return $tree->{LEFT};
		}
		
		my $min_node = find_min($tree->{RIGHT});
		$tree->{VALUE} = $min_node->{VALUE};
		$tree->{RIGHT} = remove($tree->{RIGHT}, $min_node->{VALUE});
		return $tree;
	}
	
	if ($value < $tree->{VALUE}) {
		unless ($tree->{LEFT}) {
			return $tree;
		}
		$tree->{LEFT} = remove($tree->{LEFT}, $value);
		return $tree;
	}
	
	if ($value >= $tree->{VALUE}) {
		unless ($tree->{RIGHT}) {
			return $tree;
		}
		$tree->{RIGHT} = remove($tree->{RIGHT}, $value);
		return $tree;
	}
}

sub print_tree {
	my ($tree, $offset) = @_;
	return unless $tree;
	
	my $new_offset = $offset + 5;
	print_tree($tree->{LEFT}, $new_offset);
	
	for (my $i = 0; $i < $offset; $i++) {
		print "_";
	}
	
	print "$tree->{VALUE}\n";
	
	print_tree($tree->{RIGHT}, $new_offset);
}

sub pre_order_print {
	my ($tree) = @_;
	return unless $tree;
	print "$tree->{VALUE} ";
	pre_order_print($tree->{LEFT});
	pre_order_print($tree->{RIGHT});
}

sub in_order_print {
	my ($tree) = @_;
	return unless $tree;
	in_order_print($tree->{LEFT});
	print "$tree->{VALUE} ";
	in_order_print($tree->{RIGHT});
}

sub post_order_print {
	my ($tree) = @_;
	unless ($tree) { return; }
	post_order_print($tree->{LEFT});
	post_order_print($tree->{RIGHT});
	print "$tree->{VALUE} ";
}

format menu = 
+----------------------------------+
|               Menu               |
+----------------------------------+
| 1. Add node to tree              |
| 2. Delete node from tree         |
| 3. Show pretty tree              |
|----------------------------------|
| 4. Show list (pre-order)         |
| 5. Show list (in-order )         |
| 6. Show list (post-order)        |
|----------------------------------|
| 7. Exit                          |
+----------------------------------+
.

my $tree;
while (1) {
	$~ = menu;
	write;
	print "select action: ";
    my $choice = <STDIN>;
    chomp $choice;
	
	if ($choice == 1) {
        print "write number for adding: ";
		my $value = <STDIN>;
		chomp $value;
		
		unless ($value =~ /\d{1,6}/) {
			say "write number =~ \d{1,6}";
			next;
		}
		
		add($tree, $value);		
    } 
	elsif ($choice == 2) {
		print "write number for deleting: ";
		my $value = <STDIN>;
		chomp $value;
		
		unless ($value =~ /\d{1,6}/) {
			say "write number =~ \d{1,6}";
			next;
		}
		
		$tree = remove($tree, $value);		
    } 
	elsif ($choice == 3) {
		print_tree($tree, 5);
    }
	elsif ($choice == 4) {
		print "pre-order tree: ";
        pre_order_print($tree);
		print "\n";
	} 
	elsif ($choice == 5) {
		print "in-order tree: ";
        in_order_print($tree);
		print "\n";
	} 
	elsif ($choice == 6) {
		print "post-order tree: ";
        post_order_print($tree);
		print "\n";
	} 	 
	elsif ($choice == 7) {
		say "The end!!!";
        last;
    } 
	else {
        say "Incorrect selection. Try again";
    }
}