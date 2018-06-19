@ IN SOA ns1.evilcorpca.com. DNSMaster.evilcorpca.com (
2000101804 ; serial, date + # seq
8H ; refresh, 8 heures
2H ; retry, 2 heures
1W ; expire, 1 semaine
1D ) ; minimum, 1 jour
;
			IN NS ns1.evilcorpca.com
			IN NS ns2.evilcorpca.com
			IN NS DMZ
;
			IN MX 10 @evilvorpca.com ; Primary Mail Exchanger
			IN MX 20 @evilcorp.ca. ; Secondary Mail Exchanger
;



@evilcorpca.com. 	IN A 199.48.22.55  
VPN.			In A 199.48.22.77
ns1.evilcorpca.com. 	IN A 199.48.22.28
ns2.evilcorpca.com.	IN A 199.48.22.98

DMZ.			IN A 192.168.100.0 /24
PublicDmzGw		IN A 199.48.22.100
secure.evilcorpa.com	IN A 192.168.100.100

InternalGW.		IN A 10.10.1.1
InternalFileSys.	IN A 10.10.1.89
webmail.evilcorpa.ca.	IN A 199.48.22.36	
Courriel.evilcorpa.com	IN A 199.48.22.36

