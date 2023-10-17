#ЭВМ (тип компьютера, конфигурация, принадлежность к
#той или иной сети и т.д.)
package evm;
use 5.010;
use base qw(Exporter);
our @EXPORT = qw(new);

sub new {
	my $classname = shift;
	my $fields = {};
	$fields->{classname} = $classname;
	$fields->{number} = shift;
	$fields->{type} = shift;
	$fields->{cpu} = shift;
	$fields->{ram} = shift;
	$fields->{domain} = shift;
	bless $fields, evm;
	return $fields;
}

sub info {
	my $self = shift;
	say "Type of EVM: $self->{type}";
	say "Number: $self->{number}";
	say "CPU: $self->{cpu}";
	say "RAM: $self->{ram}";
	say "domain: $self->{domain}";
	print "\n";
}

# работа с двумя объектами
sub comp_ram {
	my ($self, $other) = @_;
	return ($self->{ram} > $other->{ram})
}

# копирование объекта
sub copy {
	my $self = shift;
	my $copy_comp = new(
		evm,
		$self->{number},
		$self->{type},
		$self->{cpu},
		$self->{ram},
		$self->{domain},
	);
	return $copy_comp;
}

# увеличение объема ОЗУ
sub inc_ram {
	my $self = shift;
	my $value = shift;
	
	if ($value < 0) {
		say "volume of ram must be more 0!";
		return;
	}
	
	$self->{ram} += $value;
}

1;

# список объектов
# метод работающий с двумя объектами (конструктор копии / сравнение)