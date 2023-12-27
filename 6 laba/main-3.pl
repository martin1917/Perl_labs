# 3. Решить задачу, обратную предыдущей — изменить форму записи
# чисел с римской на арабскую
# [Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding("utf-8")

use 5.010;
use Getopt::Long;

sub roman_to_arabic {
    my ($roman) = @_;
	
    my %roman_numerals = (
        'I' => 1, 'V' => 5, 'X' => 10, 'L' => 50,
        'C' => 100, 'D' => 500, 'M' => 1000
    );

    my $result = 0;
    my $prev_value = 0;
    foreach my $char (reverse split('', $roman)) {
        my $value = $roman_numerals{$char};
        if ($value < $prev_value) {
            $result -= $value;
        } else {
            $result += $value;
        }
        $prev_value = $value;
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
open(my $fileWrite, ">", "arabic_digits_res.txt");

while(my $line = <$fileRead>) {	
	$line =~ s{^(?=.)(M*)(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$}{roman_to_arabic("$1$2$3$4")}ge;
	print $fileWrite $line;
}

close($fileWrite);
close($fileRead);