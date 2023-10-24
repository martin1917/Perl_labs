# 4. Разработать программу, которая во входном файле выполняет
# преобразование русского текста из одной кодировки в другую. Системы
# кодировки выбираются в соответствии с номером бригады.

use 5.010;
use Getopt::Long;

say "Преобразовать файл:";
my ($from_encoding, $to_encoding);
while (1) {
	print "1. из кодировки 'cp866'  в кодировку 'cp1251'\n";
	print "2. из кодировки 'cp1251' в кодировку 'cp866'\n";
	print "выбор: ";
	my $answer = <STDIN>;
	chomp $answer;
	
	if ($answer == 1) {
		($from_encoding, $to_encoding) = ("cp866", "cp1251");
		last;
	}
	elsif ($answer == 2) {
		($from_encoding, $to_encoding) = ("cp1251", "cp866");
		last;
	}
	else {
		say "Напишите 1 или 2!!!";
	}
}

say "Укажите путь до файла:";
my $path_file;
while (1) {
	print "путь: ";
	$path_file = <STDIN>;
	chomp $path_file;
	if (-f $path_file) {
		last;
	}
	else {
		say "Такого файла не существует";
	}
}

say "Укажите название файла для сохранения:";
print "путь: ";
my $save_path = <STDIN>;
chomp $save_path;

open(my $fileRead, "<:encoding($from_encoding)", $path_file) or die("Нет такого файла\n");
open(my $fileWrite, ">:encoding($to_encoding)", $save_path);
print $fileWrite $_ while(<$fileRead>);
close($fileWrite);
close($fileRead);