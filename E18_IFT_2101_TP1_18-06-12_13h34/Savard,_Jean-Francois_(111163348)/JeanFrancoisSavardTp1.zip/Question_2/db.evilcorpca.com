$TTL	1D
@	IN	SOA	ns1.evilcorpca.com. admin.evilcorpca.com. (
			2018060301		; serial, date + # sequence
			8H			; refresh, 8 heures
			2H			; retry, 2 heures
			1W			; expire, 1 semaine
			1D )			; minimum, 1 jour
; name servers - NS records
	IN	NS	ns1			 ;
	IN	NS	ns2			 ;
; mail servers - MX records
	IN	MX	10 courriel		 ;
; name servers - A records
ns1	IN	A	199.48.22.28
ns2	IN	A	199.48.22.98
; 199.48.22.0 /24 - A records
courriel IN	A	199.48.22.55
webmail	IN	A 	199.48.22.36
vpn	 IN	A	199.48.22.77
www	 IN	A	199.48.22.99
secure	 IN	A	199.48.22.100
;

