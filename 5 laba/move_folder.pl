# Разработать программу, которая перемещает каталог вместе со
# всем его содержимым. Имя исходного каталога и место назначения
# вводятся пользователем.
use 5.010;
use Getopt::Long;
use Cwd qw(cwd);

sub move_folder {
	my ($source_dir, $source_path, $target_path) = @_;
	while (my $file = readdir($source_dir)) {
		next if ($file =~ /^\..*/);
		if (-f $file) {
			open(my $hr, "<$file");
			open(my $hw, ">$target_path/$file");
			print $hw "$_" while(<$hr>);
			close($hw);
			close($hr);
			unlink $file;
		}
		if (-d $file) {
			my $next_source_path = "$source_path/$file";
			my $next_target_path = "$target_path/$file";			
			mkdir($next_target_path);			
			opendir(my $dir, $next_source_path);
			chdir($next_source_path);
			move_folder($dir, $next_source_path, $next_target_path);
			chdir($source_path);
			closedir($dir);
			rmdir($next_source_path);
		}
	}
}

sub check {
	my ($source_path, $target_path) = @_;
	
	my $error = "";
	unless ($source_path) {
		$error .= "Source folder path is empty\n";
		$error .= "Please add argument '--source <path_to_folder>'";
	}

	unless ($target_path) {
		$error .= "Target folder path is empty";
		$error .= "Please add argument '--target <path_to_folder>'";
	}
	
	return $error;
}

sub main {
	# получение аргументов
	my $cwd = cwd($0);
	my ($source_path, $target_path);
	GetOptions("source=s" => \$source_path, "target=s" => \$target_path);
	$source_path =~ s{\\}{\/}g;
	$target_path =~ s{\\}{\/}g;
	
	# проверка аргументов
	my $error = check($source_path, $target_path);
	if ($error) {
		print $error;
		exit;
	}
	
	# Проверяем что папка, в которую перемещаем, существует
	unless (-d $target_path) {
		say "not found folder - $target_path";
		say "create target folder before copy";
		exit;
	}

	# Создаем папку для перемещения
	my @parts = grep { $_ } split(/\//, $source_path);
	my $name_folder = $parts[-1];
	my $target_path = "$target_path/$name_folder";
	unless ($target_path cmp $source_path) {
		$target_path .= "_COPY";
	}
	mkdir("$target_path") or die("FolderError - $target_path ($!)\n");

	# перемещаем
	opendir(my $source_dir, $source_path) or die("FolderError - $source_path ($!)\n");
	chdir($source_path);
	move_folder($source_dir, $source_path, $target_path);
	chdir($cwd);
	closedir($source_dir);
	rmdir($source_path);
}

main();