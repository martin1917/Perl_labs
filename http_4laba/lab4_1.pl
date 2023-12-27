use HTTP::Request;
use LWP::UserAgent;
use IO::Socket;
		
$menu = [
	[1, 'Получить опции сервера'],
	[2, 'Получить опции ресурса'],
	[3, 'Выйти']
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

	my $sock = new IO::Socket::INET (
		PeerAddr => $server_addr,
		PeerPort => $server_port,
		Type     => SOCK_STREAM,
		Proto => 'tcp',
		);
    
    $key = <STDIN>;
    if($key == 1) {
		die "Could not create Internet TCP socket: $!\n" unless $sock;	
		print $sock "OPTIONS * HTTP/1.0\r\n\r\n";
		print while <$sock>;
		print "\n";
		close($sock); 
    } 
	elsif($key == 2) {
		my $url = "http://$server_addr:$server_port";
		
        print "Введите адрес ресурса на сервере $url/";
        $resource = <>;
      
        $ua = LWP::UserAgent->new();
		$r = HTTP::Request->new(OPTIONS => "$url/$resource");
        $res = $ua->request($r);

        print $res->as_string;
    } 
	elsif($key == 3) {
        $is_alive = ""; 
    } 
	else {
        print "Введены неверные данные. Попробуйте заново\n\n";        
    }
}    
 
