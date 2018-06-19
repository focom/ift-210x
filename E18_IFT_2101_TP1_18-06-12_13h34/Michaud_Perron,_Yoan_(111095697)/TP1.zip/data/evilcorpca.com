@ IN SOA ns1.evilcorpca.com. yoan.michaud-perron.1.ulaval.ca (
        1	;serial
        3H	;refresh
        15M     ;retry
        1W	;expire
        1D	;TTL
        )
		IN	NS	ns1.evilcorpca.com.
		IN	NS	ns2.evilcoprca.com.
		IN	MX	10 courriel.evilcorpca.com.
		IN	DNAME	evilcorpca.com.
www		IN	A	199.48.22.99
secure		IN	A	199.48.22.100
courriel	IN	A	199.48.22.55
webmail		IN	A	199.48.22.36
vpn		IN	A	199.48.22.77
ns1		IN	A	199.48.22.28
ns2		IN	A	199.48.22.98


