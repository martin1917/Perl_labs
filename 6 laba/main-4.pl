# 4. Разработать программу, которая во входном файле выполняет
# преобразование русского текста из одной кодировки в другую. Системы
# кодировки выбираются в соответствии с номером бригады.

use 5.010;
use utf8;

# Выбор преобразования
say "Преобразовать файл:";
my $answer;
my ($from, $to);
while (1) {
	print "1. из кодировки 'cp866'  в кодировку 'cp1251'\n";
	print "2. из кодировки 'cp1251' в кодировку 'cp866'\n";
	print "выбор: ";
	$answer = <STDIN>;
	chomp $answer;
	
	if ($answer == 1) {
		($from, $to) = ("cp866", "cp1251");
		last;
	}
	
	if ($answer == 2) {
		($from, $to) = ("cp1251", "cp866");
		last;
	}
	
	say "Напишите 1 или 2";
}

# Путь исходного файла
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

# Путь результирующего файла
say "Укажите название файла для сохранения:";
print "путь: ";
my $save_path = <STDIN>;
chomp $save_path;

open(my $fileRead, "<:encoding($from)", $path_file) or die("Нет такого файла\n");
open(my $fileWrite, ">:encoding($to)", $save_path);

while (my $line = <$fileRead>) {
	if ($answer == 1) {
		$line =~ tr{\x80-\x9F\xA0-\xEF}{\xC0-\xDF\xE0-\xFF};
	}
	if ($answer == 2) {
		$line =~ tr{\xC0-\xDF\xE0-\xFF}{\x80-\x9F\xA0-\xEF};
	}
	
	print $fileWrite $line;
}

close($fileWrite);
close($fileRead);