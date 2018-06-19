@		IN	SOA	ns1.evilcorpca.com	admin.evilcorpca.com (
				2018052701		;serial
				8H			;refresh
				2H			;retry
				1W			;expire
				1D )			;minimum
;
		IN	NS	ns1
		IN	NS	ns2
		IN	MX	10 courriel
localhost	IN	A	127.0.0.1
ns1		IN	A	199.48.22.28
ns2		IN	A	199.48.22.98
www		IN	A	199.48.22.99
webmail		IN	A	199.48.22.36
secure		IN	A	199.48.22.100
courriel 	IN	A	199.48.22.55
courriel	IN	CNAME	webmail			;Deux entre au meme nom?
vpn		IN	A	199.48.22.77
