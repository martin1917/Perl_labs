# Разработать программу, которая просматривает дерево каталогов и
# удаляет файлы с заданным расширением. Требуемое расширение вводится
# с клавиатуры или через командную строку. В качестве корня дерева
# использовать каталог, имя которого вводится пользователем.

use 5.010;
use Getopt::Long;

sub delete_files_by_ext {
	my ($dir, $path, $ext) = @_;
	unlink glob(qq("$path/*.$ext"));
	while (my $file = readdir($dir)) {
		next if ($file =~ /^\..*/);
		if (-d $file) {
			my $next_path = "$path/$file";
			opendir(my $next_dir, "$next_path") or die("FolderError - $next_path ($!)\n");
			chdir($next_path);
			delete_files_by_ext($next_dir, $next_path, $ext);
			chdir($path);
			closedir($next_dir);
		}
	}
}

# Получение аргументов из терминала
my ($path_folder, $ext);
GetOptions("folder=s" => \$path_folder, "ext=s" => \$ext);
$path_folder =~ s{\\}{\/}g;

# Проверка, что все необходимые аргументы введены
my $error = "";
unless ($path_folder) {
	$error .= "Folder path is empty\n";
	$error .= "Please add argument '--folder <path_to_folder>'\n";
}

unless ($ext) {
	$error .= "extension is empty\n";
	$error .= "Please add argument '--ext <extension> (example: exe, txt)'\n";
}

if (length($error) > 0) {
	print $error;
	exit;
}

# удаляем файл с указанным расширением
opendir(my $root, "$path_folder") or die("FolderError - $path_folder\n");
chdir($path_folder);
delete_files_by_ext($root, $path_folder, $ext);
closedir($root);