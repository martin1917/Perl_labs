# Разработать программу, которая просматривает дерево каталогов и
# удаляет файлы с заданным расширением. Требуемое расширение вводится
# с клавиатуры или через командную строку. В качестве корня дерева
# использовать каталог, имя которого вводится пользователем.

use 5.010;
use Getopt::Long;
use Encode qw(encode decode);
use utf8;

sub delete_files_by_ext {
	my ($dir, $path, $ext) = @_;
	unlink glob(qq("$path/*.$ext"));
	while (my $file = readdir($dir)) {
		next if ($file =~ /^\..*/);
		if (-d $file) {
			my $next_path = "$path/$file";
			opendir(my $next_dir, "$next_path") or die("FolderError - $next_path\n");
			chdir($next_path);
			delete_files_by_ext($next_dir, $next_path, $ext);
			chdir($path);
			closedir($next_dir);
		}
	}
}

my ($path_folder, $ext);
GetOptions(
	"folder=s" => \$path_folder,
	"ext=s"   => \$ext);

chomp $path_folder;
chomp $ext;

unless ($path_folder) {
	say "Аргумент 'folder' не указан";
	say "Пожалуйста добавьте аргумент '--folder <path_to_folder>'";
	exit;
}

unless ($ext) {	
	say "Аргумент 'ext' не указан";
	say "Пожалуйста добавьте аргумент '--ext <extension> (например, exe, txt)'";
	exit;
}

$path_folder =~ s{\\}{\/}g;
opendir(my $root, "$path_folder") or die("FolderError - $path_folder\n");
chdir($path_folder);
delete_files_by_ext($root, $path_folder, $ext);
closedir($root);