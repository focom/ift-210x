$TTL    3H
@	IN SOA     ns1.evilcorpca.com. adminserver.evilcorpca.com. (
                           201806051  	; serial
                           8H       	; refresh
                           2H       	; retry
                           1W      		; expire
                           1D )     	; minimum
; Serveur de noms - NS
@				IN	NS	ns1.evilcorpca.com.
@				IN	NS	ns2.evilcorpca.com.	
; Serveur de noms - A
ns1				IN	A	199.48.22.28
ns2				IN	A	199.48.22.98
; Serveur de courriel - MX
				IN	MX	10 courriel.evilcorpca.com.
				IN	MX	20 courriel.evilcorp.ca.
; Adressage - A
courriel			IN	A	199.48.22.55
vpn				IN	A	199.48.22.77
www				IN	A	199.48.22.99
webmail				IN	A	199.48.22.36
secure				IN	A	192.48.22.100	
; Alias de nom - CNAME
evilcorp.ca.			IN 	CNAME	evilcorpca.com.
