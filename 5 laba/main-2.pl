# Разработать программу, которая печатает дерево каталогов и
# имена содержащихся в них файлов с их атрибутами (размер, дата и время
# создания, доступность для чтения и записи). В качестве корня дерева
# использовать каталог, имя которого вводится пользователем.
# Предусмотреть возможность вывода информации как на экран, так и в
# текстовый файл. Решение о способе вывода информации принимается на
# основе списка аргументов программы, переданного ей через командную
# строку.

use 5.010;
use Getopt::Long;

sub get_pretty_time {
	my ($ctime) = @_;
	my @time = localtime($ctime);
	my ($year, $month, $day) = (1900 + $time[5], 1 + $time[4], $time[3]);
	my ($hour, $min, $sec) = ($time[2], $time[1], $time[0]);
	return "$day.$month.$year $hour:$min:$sec";
}

sub get_file_info {
	my ($file) = @_;
	my $bytes = -s $file;
	my @stat = stat($file);
	my $dt = get_pretty_time($stat[10]);
	my $readable = (-r $file) + 0;
	my $writeable = (-w $file) + 0;
	return "bytes: $bytes; dt: $dt; read: $readable; write: $writeable\n"; 
}

sub print_fs_tree {
	my ($dir, $path, $offset) = @_;
	while (my $file = readdir($dir)) {
		next if ($file =~ /^\..*/);		
		for my $i (1..$offset) { print " "; }
		if (-d $file) {
			print "folder: '$file'\n";
			my $next_path = "$path/$file";
			opendir(my $next_dir, "$next_path") or die("FolderError - $next_path\n");
			chdir($next_path);
			print_fs_tree($next_dir, $next_path, $offset + 4);
			chdir($path);
			closedir($next_dir);
		}
		if (-f $file) {
			my $file_info = get_file_info($file);
			print "file: '$file' $file_info";
		}
	}
}

################################################################################################

my ($path_folder, $path_output);
GetOptions(
	"folder=s" => \$path_folder,
	"file=s"   => \$path_output);

chomp $path_folder;
chomp $path_output;

unless ($path_folder) {
	say "Folder path empty";
	say "Please add argument '--folder <path_to_folder>'";
	exit;
}

if ($path_output) {
	open(my $file, ">$path_output") or die("OutputFileError\n");
	select $file;
}

say $path_folder;
opendir(my $root, "$path_folder") or die("FolderError - $path_folder\n");
chdir($path_folder);
print_fs_tree($root, $path_folder, 0);
closedir($root);