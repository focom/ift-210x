@		IN	SOA	dns.evilcorpca.com. DNSMaster.evilcorpca.com. (
				2018060801				;serial date + #seq
				8H					;refresh, 8 heures
				2H					;retry, 2 heures
				2H              		   	;retry, 2 heures
				1W     					;expire, 1 semaine
                	        1D )   					;minimum, 1 jour
;
		IN	TXT	"Voici le fichier de configuration"
		IN	NS	ns1					;Adresse du DNS primaire
		IN	NS	ns2					;Adresse du DNS secondaire
		IN	MX	courriel				;Primary mail
		IN	MX	courriel.evilcorpca.com			;Secondary mail
localhost	IN	A	127.0.0.1
courriel	IN	A	199.48.22.55
gw		IN	A	199.48.22.100				;Passerelle de paiement
		IN	TXT	"Payment Gateway"
gw		IN	A	199.48.22.36				;Passerelle de courriels
		IN	TXT	"Email Gateway"
gw		IN	A	10.10.1.1				;Passerelle interne
		IN	TXT	"Internal Gateway"
ftp		IN	A	10.10.1.89
dmz		IN	A	192.168.100.0				;DMZ
vpn		IN	A	vpn					;VPN
