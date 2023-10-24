# Разработать программу, которая перемещает каталог вместе со
# всем его содержимым. Имя исходного каталога и место назначения
# вводятся пользователем.
use 5.010;
use Getopt::Long;

sub copy_folder {
	my ($source_dir, $source_path, $target_path) = @_;
	while (my $file = readdir($source_dir)) {
		next if ($file =~ /^\..*/);
		if (-f $file) {
			open(my $hr, "<$file");
			open(my $hw, ">$target_path/$file");
			print $hw "$_" while(<$hr>);
			close($hw);
			close($hr);
		}
		if (-d $file) {
			mkdir("$target_path/$file");
			opendir(my $dir, $file);
			chdir($file);
			copy_folder($dir, "$source_path/$file", "$target_path/$file");
			chdir($source_path);
			closedir($dir)
		}
	}
}

# Получение аргументов из терминала
my ($source_path, $target_path);
GetOptions("source=s" => \$source_path, "target=s" => \$target_path);
$source_path =~ s{\\}{\/}g;
$target_path =~ s{\\}{\/}g;

# Проверка, что все необходимые аргументы введены
my $error = "";
unless ($source_path) {
	$error .= "Source folder path is empty\n";
	$error .= "Please add argument '--source <path_to_folder>'";
}

unless ($target_path) {
	$error .= "Target folder path is empty";
	$error .= "Please add argument '--target <path_to_folder>'";
}

if (length($error) > 0) {
	print $error;
	exit;
}

# Проверяем что папка, в которую копируем, существует
unless (-d $target_path) {
	say "not found folder - $target_path";
	say "create target folder before copy";
	exit;
}

# Создаем папку для копирования
my @parts = grep { $_ } split(/\//, $source_path);
my $name_folder = $parts[-1];
my $target_path = "$target_path/$name_folder";
unless ($target_path cmp $source_path) {
	$target_path .= "_COPY";
}
mkdir("$target_path") or die("FolderError - $target_path ($!)\n");

# Копируем
opendir(my $source_dir, $source_path) or die("FolderError - $source_path ($!)\n");
chdir($source_path);
copy_folder($source_dir, $source_path, $target_path);
closedir($source_dir);