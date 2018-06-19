$TTL 86400
@	IN	SOA	 evilcorpca.com.	DNSMaster.evilcorpca.com. (
2000101804 ; serial, date + # sequentiel
8H ; refresh, 8 heures
2H ; retry, 2 heures
1W ; expire, 1 semaine
1D ) ; minimum, 1 jour
;
IN	 NS	 ns1.evilcorpa.com ; Adresse du DNS
IN	 NS	 ns2.evilcorpa.com ;
;
IN	 MX	 10 courriel ; Primary Mail Exchanger
IN	 MX	 20 courriel.evilcorpca.com. ; Secondary Mail Exchanger
;
ns1	 IN	 A	 199.48.22.28
ns2	 IN	 A	 199.48.22.98
fichiers.evilcorpca.local	 IN	 A	 10.10.1.89
passerelle.evilcorpca.local	 IN	 A	 10.10.1.1
vpn	 IN	 A	 199.48.22.77
www	 IN	 CNAME	evilcorp.ca
paiement	IN 	A 	199.48.22.100
