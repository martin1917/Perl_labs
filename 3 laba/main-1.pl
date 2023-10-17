use 5.010;

format menu = 
+----------------------------------+
|               Menu               |
+----------------------------------+
| 1. Add student to list           |
| 2. Delete student by number      |
| 3. Show all students             |
| 4. Exit                          |
+----------------------------------+
.

my $list = undef;
while (1) {
	$~ = menu;
	write;
	print "select action: ";
    my $choice = <STDIN>;
    chomp $choice;
	if ($choice == 1) {
		my $new_student = {};
		
		print "write FIO: ";
		my $fio = <STDIN>;
		chomp $fio;
		$new_student->{fio} = $fio;
		
		print "write number: ";
		my $number = <STDIN>;
		chomp $number;
		$new_student->{number} = $number;
		
		print "write group: ";
		my $group = <STDIN>;
		chomp $group;
		$new_student->{group} = $group;
		
		print "write specialty: ";
		my $specialty = <STDIN>;
		chomp $specialty;
		$new_student->{specialty} = $specialty;
		
		print "write birth year: ";
		my $birth_year = <STDIN>;
		chomp $birth_year;
		$new_student->{birth_year} = $birth_year;
		
        add_element($list, $new_student);
    } elsif ($choice == 2) {
		print "write number for deleting: ";
		my $number = <STDIN>;
		chomp $number;
		
        remove_element($list, $number);
    } elsif ($choice == 3) {
		say "============OUTPUT==================";
        print_list($list);
		say "====================================";
	} elsif ($choice == 4) {
		say "The end!!!";
        last;
    } else {
        say "Incorrect selection. Try again";
    }
}

sub add_element {
	my ($list, $new_student) = @_;
	
	unless ($list) {
		$_[0] = {
			student => $new_student,
			next => undef
		};		
		return;
	}
	
	my $new_number = $new_student->{number};
	my $number_of_current = $list->{student}->{number};
	
	if ($new_number < $number_of_current) {
		my $new_node = {
			student => $new_student,
			next => $list
		};			
		$_[0] = $new_node;
		return;
	}
	
	if (!$list->{next}) {
		if ($new_number != $number_of_current) {
			$list->{next} = {
				student => $new_student,
				next => undef
			};
		} else {
			say "\nAdding are failed. Student with this number ($new_number) already exist!\n";
		}
		return;
	}
	
	my $number_of_next = $list->{next}->{student}->{number};
	if ($new_number > $number_of_current) {
		if ($new_number < $number_of_next) {
			my $new_node = {
				student => $new_student,
				next => $list->{next}
			};			
			$list->{next} = $new_node;
		} else {
			add_element($list->{next}, $new_student);
		}
	}
}

sub remove_element {
	my ($list, $number) = @_;
	return unless $list;
	
	if ($number == $list->{student}->{number}) {
		$_[0] = $_[0]->{next};
		return;
	}
	
	if ($list->{next} && $list->{next}->{student}->{number} == $number) {
		my $delete_elem = $list->{next};
		$list->{next} = $delete_elem->{next};
		return;
	}
	
	remove_element($list->{next}, $number);
}

sub print_list {
	my ($list) = @_;
	return unless $list;
	my $student = $list->{student};
	say "FIO: $student->{fio}";
	say "Number: $student->{number}";
	say "Group: $student->{group}";
	say "Specialty: $student->{specialty}";
	say "Birth year: $student->{birth_year}";
	say "---------------------------\n";
	print_list($list->{next});
}