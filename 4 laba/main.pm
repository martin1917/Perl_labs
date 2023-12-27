use 5.010;
use evm;

sub get_elem {
	my ($list, $num) = @_;
	unless ($list) {
		return undef;
	}
	
	if ($num > $list->{comp}->{number}) {
		return get_elem($list->{next}, $num);
	}
	
	return $list->{comp};
}

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
			say "\nДобавление провалено. Компьютер с номером ($new_number) уже существует!\n";
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
| 1. Добавление компьютера         |
| 2. Удаление компьютера по номеру |
| 3. Показать все компьютеры       |
| 4. Сравнение по ОЗУ              |
| 5. Выход                         |
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

say "=====Начальный список=================";
print_list($list);
say "====================================\n";

# сравнение двух объектов по одному из полей
#say "Сравнение 2 компьютеров";
#my $res = $obj1->comp_ram($obj2);
#print "$obj1->{type}($obj1->{ram}) vs $obj2->{type}($obj2->{ram}): $res\n";

while (1) {
	$~ = menu;
	write;
	print "Выберите действие: ";
    my $choice = <STDIN>;
    chomp $choice;
	if ($choice == 1) {		
		print "Напишите номер компьютера: ";
		my $number = <STDIN>;
		chomp $number;
		
		print "Напишите имя компьютера: ";
		my $comp_name = <STDIN>;
		chomp $comp_name;
		
		print "Напишите название процессора: ";
		my $cpu = <STDIN>;
		chomp $cpu;
		
		print "Напишите объем ОЗУ: ";
		my $ram = <STDIN>;
		chomp $ram;
		
		print "Напишите домен: ";
		my $domain = <STDIN>;
		chomp $domain;
		
        add_element($list, evm->new($number, $comp_name, $cpu, $ram, $domain));
    } elsif ($choice == 2) {
		print "Напишите номер для удаления: ";
		my $number = <STDIN>;
		chomp $number;
		
        del_elem($list, $number);
    } elsif ($choice == 3) {
		say "============ВЫВОД===================";
        print_list($list);
		say "====================================";
	} elsif ($choice == 4) {
		print "Напишите номер первого комьютера: ";
		my $num1 = <STDIN>;
		chomp $num1;
		
		print "Напишите номер второго комьютера: ";
		my $num2 = <STDIN>;
		chomp $num2;
		
		my $comp1 = get_elem($list, $num1);
		my $comp2 = get_elem($list, $num2);
		
		unless ($comp1) {
			say "Компьютера с номером $num1 нет в списке";
			last;
		}
		
		unless ($comp2) {
			say "Компьютера с номером $num2 нет в списке";
			last;
		}
		
		my $res = $comp1->comp_ram($comp2);
		if ($res == 1) {
			say "$comp1->{type}($comp1->{ram}) > $comp2->{type}($comp2->{ram})";
		}
		if ($res == 0) {
			say "$comp1->{type}($comp1->{ram}) == $comp2->{type}($comp2->{ram})";
		}
		if ($res == -1) {
			say "$comp1->{type}($comp1->{ram}) < $comp2->{type}($comp2->{ram})";
		}
		
	} elsif ($choice == 5) {
		say "The end!!!";
        last;
    } else {
        say "Неверный ввод. Попробуйте еще раз";
    }
}