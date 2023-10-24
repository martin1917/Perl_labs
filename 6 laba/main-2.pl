# 2. Разработать программу, которая во входном файле отыскивает
# последовательности символов (лексемы), соответствующие записи чисел
# арабскими цифрами, и заменяет их последовательностями символов,
# соответствующих записи чисел римскими цифрами. Имя входного файла
# вводится через командную строку или с клавиатуры.
# [Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding("utf-8")

use 5.010;
use Getopt::Long;

sub arabic_to_roman {
    my ($number) = @_;
	
    my @roman_numerals = (
		[1000, "M"], 
		[900, "CM"], [500, "D"], [400, "CD"], [100, "C"], 
		[90, "XC"], [50, "L"], [40, "XL"], [10, "X"], 
		[9, "IX"], [5, "V"], [4, "IV"], [1, "I"]
    );

    my $result = "";
    foreach my $numeral (@roman_numerals) {
        while ($number >= $numeral->[0]) {
            $result .= $numeral->[1];
            $number -= $numeral->[0];
        }
    }
    return $result;
}

my $path_file;
GetOptions("file=s" => \$path_file);
chomp $path_file;

unless ($path_file) {
	say "Путь к файлу не указан";
	say "Добавьте аргумент '--file <path_to_file>'";
	exit;
}

open(my $fileRead, "<", $path_file) or die("Нет такого файла\n");
open(my $fileWrite, ">", "rim_digits_res.txt");

while(my $line = <$fileRead>) {
	$line =~ s/(\d+)/arabic_to_roman($1)/ge;
	print $fileWrite $line;
}

close($fileWrite);
close($fileRead);