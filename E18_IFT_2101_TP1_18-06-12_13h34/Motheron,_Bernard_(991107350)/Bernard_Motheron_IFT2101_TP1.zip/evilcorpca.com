$TTL 1D
@		IN 	SOA	ns1.evilcorpca.com. DNSMaster.evilcorpca.com.(
					0	; serial
					1D	; refresh
					1H	; retry
					1W	; expire
					3H )	; minimum
; 	
		IN	TXT 	"Cours IFT-2101 été 2018"
		IN	NS   	ns1			; Primary DNS
		IN 	NS   	ns2			; Secondary DNS
		IN	MX   	55 courriel		; Primary mail
		IN	MX	36 webmail		; Secondary mail employes
localhost	IN	A	127.0.0.1
ns1		IN	A	199.48.22.28
ns2		IN	A	199.48.22.98
vpn		IN	A	199.48.22.77
passerelle	IN	A	10.10.1.1
fichiers	IN	A	10.10.1.89
secure		IN	A	192.168.100.100
www		IN	CNAME	evilcorpca.com.
www.evilcorp.ca IN	CNAME	www


