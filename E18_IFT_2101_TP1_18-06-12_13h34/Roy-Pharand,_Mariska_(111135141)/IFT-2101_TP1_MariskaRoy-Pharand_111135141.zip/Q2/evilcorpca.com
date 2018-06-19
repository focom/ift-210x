@			IN	SOA	ns1.evilcorpca.com.	dnsmaster.evilcorpca.com. (
					2018052701		; serial, data + # séquentiel
					8H			; refresh, 8 heures
					30M			; retry, 30 minutes
					1W			; expire, 1 semaine
					1D			; minimum, 1 jour
);

			IN	NS	ns1
			IN	NS	ns2

			IN	MX	courriel

ns1			IN	A	199.48.22.28
ns2			IN	A	199.48.22.98

courriel		IN 	A	199.48.22.55
webmail			IN	CNAME	courriel

www			IN	A	199.48.22.97

secure			IN	A	199.48.22.100

vpn			IN	A	199.48.22.77


