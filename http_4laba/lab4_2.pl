use HTTP::Request;
use LWP::UserAgent;
use HTTP::Headers;

$menu = [
	[1, 'Выполнить GET-запрос'],
	[2, 'Выполнить POST-запрос'],
	[3, 'Выполнить HEAD-запрос'],
	[4, 'Выйти'],
];

$server_addr = "localhost";
$server_port = "9080";

$is_alive = 1;
while($is_alive) {
    print "-------------------------\n";
    print "Выберите пункт меню:\n";
	
    foreach $row (@$menu) {
		print "@$row[0]) @$row[1]\n";
	}

    $key = <STDIN>;
	
	my $url = "http://$server_addr:$server_port";
	
    if($key == 1)
    {
        print "Введите адрес ресурса $url/";
        $resource = <>;
        chomp $resource;            

        $r = HTTP::Request->new(GET, "$url/$resource");            

        $ua = LWP::UserAgent->new();
        $res = $ua->request($r);

        ($resp = $res->as_string) =~ s/\n\n.+//s;

        open(FH_h, '>get_head.txt') or die $!;
        open(FH_c, '>get_content.txt') or die $!;

        print FH_h $resp;            
        print FH_c $res->content;
        
        close(FH_h);
        close(FH_c);
    }
    elsif($key == 2)
    {
		print "Введите адрес ресурса $url/";
        $resource = <>;
        chomp $resource;            

        $h = HTTP::Headers->new;
        $h->header('site_header',$resource);   
        
        $r = HTTP::Request->new(POST, "$url/$resource");            
        $ua = LWP::UserAgent->new();
        $res = $ua->request($r);
        ($resp = $res->as_string) =~ s/\n\n.+//s;

        open(FH_h, '>post_head.txt') or die $!;
        open(FH_c, '>post_content.txt') or die $!;

        print FH_h $resp;            
        print FH_c $res->content;
    
        close(FH_h);
        close(FH_c);
    }
    elsif($key == 3)
    {
		print "Введите адрес ресурса $url/";
        $resource = <>;
        chomp $resource;            

        $h = HTTP::Headers->new;
        $h->header('site_header',$resource);   
        $r = HTTP::Request->new(HEAD, "$url/$resource");            
        $ua = LWP::UserAgent->new();
        $res = $ua->request($r);
        ($resp = $res->as_string) =~ s/\n\n.+//s;

        open(FH_h, '>head_head.txt') or die $!;
        open(FH_c, '>head_content.txt') or die $!;

        print FH_h $resp;            
        print FH_c $res->content;

        close(FH_h);
        close(FH_c);
    }
    elsif($key == 4)
    {
        $is_alive = ""; 
    }
    else
    {
        print "Введены неверные данные. Попробуйте заново\n\n";        
    }
}    
