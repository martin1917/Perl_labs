use 5.010;
use evm;

sub add_element {
	my ($list, $new_comp) = @_;
	
	unless ($list) {
		$_[0] = {
			comp => $new_comp,
			next => undef
		};		
		return;
	}
	
	my $new_number = $new_comp->{number};
	my $number_of_current = $list->{comp}->{number};
	
	if ($new_number < $number_of_current) {
		my $new_node = {
			comp => $new_comp,
			next => $list
		};			
		$_[0] = $new_node;
		return;
	}
	
	if (!$list->{next}) {
		if ($new_number != $number_of_current) {
			$list->{next} = {
				comp => $new_comp,
				next => undef
			};
		} else {
			say "\nAdding are failed. Computer with this number ($new_number) already exist!\n";
		}
		return;
	}
	
	my $number_of_next = $list->{next}->{comp}->{number};
	if ($new_number > $number_of_current) {
		if ($new_number < $number_of_next) {
			my $new_node = {
				comp => $new_comp,
				next => $list->{next}
			};			
			$list->{next} = $new_node;
		} else {
			add_element($list->{next}, $new_comp);
		}
	}
}

sub print_list {
	my ($list) = @_;
	return unless $list;
	$list->{comp}->info();
	say "---------------------------\n";
	print_list($list->{next});
}

sub del_elem {
	my ($list, $number) = @_;
	return unless $list;
	
	if ($number == $list->{comp}->{number}) {
		$_[0] = $_[0]->{next};
		return;
	}
	
	if ($list->{next} && $list->{next}->{comp}->{number} == $number) {
		my $delete_elem = $list->{next};
		$list->{next} = $delete_elem->{next};
		return;
	}
	
	del_elem($list->{next}, $number);
}

format menu = 
+----------------------------------+
|               Menu               |
+----------------------------------+
| 1. Add computer to list          |
| 2. Delete computer by number     |
| 3. Show all computers            |
| 4. Exit                          |
+----------------------------------+
.

my $list = undef;

my $obj1 = evm->new(4, "super_computer", "zeon ex9876", 2048, "www.factory13.com");
my $obj2 = evm->new(2, "personal_computer", "intel i5-6600k", 16, "www.example.com");
add_element($list, $obj1);
add_element($list, $obj2);

# копирование объекта
my $copy = $obj2->copy();
$copy->{type} = "COPY $copy->{type}";
$copy->{number} = 0;
add_element($list, $copy);

say "=====Default computers in system====";
print_list($list);
say "====================================\n";

# сравнение двух объектов по одному из полей
say "compare 2 computers";
my $res = $obj1->comp_ram($obj2);
print "$obj1->{type}($obj1->{ram}) vs $obj2->{type}($obj2->{ram}): $res\n";

while (1) {
	$~ = menu;
	write;
	print "select action: ";
    my $choice = <STDIN>;
    chomp $choice;
	if ($choice == 1) {		
		print "write computer name: ";
		my $comp_name = <STDIN>;
		chomp $comp_name;
		
		print "write computer number: ";
		my $number = <STDIN>;
		chomp $number;
		
		print "write cpu: ";
		my $cpu = <STDIN>;
		chomp $cpu;
		
		print "write RAM volume: ";
		my $ram = <STDIN>;
		chomp $ram;
		
		print "write domain: ";
		my $domain = <STDIN>;
		chomp $domain;
		
        add_element($list, evm->new($comp_name, $number, $cpu, $ram, $domain));
    } elsif ($choice == 2) {
		print "write number for deleting: ";
		my $number = <STDIN>;
		chomp $number;
		
        del_elem($list, $number);
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