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

my ($source_path, $target_path);
GetOptions(
	"source=s" => \$source_path,
	"target=s"   => \$target_path);

chomp $source_path;
chomp $target_path;

unless ($source_path) {
	say "Source folder path is empty";
	say "Please add argument '--source <path_to_folder>'";
	exit;
}

unless ($target_path) {
	say "Target folder path is empty";
	say "Please add argument '--target <path_to_folder>'";
	exit;
}

unless (-d $target_path) {
	say "not found folder - $target_path";
	say "create target folder before copy";
	exit;
}

my @parts = grep { $_ } split(/\//, $source_path);
my $name_folder = $parts[-1];
my $target_path = "$target_path/$name_folder";
mkdir("$target_path") or die("FolderError - $target_path ($!)\n");;

opendir(my $source_dir, $source_path) or die("FolderError - $source_path ($!)\n");
chdir($source_path);
copy_folder($source_dir, $source_path, $target_path);
closedir($source_dir);