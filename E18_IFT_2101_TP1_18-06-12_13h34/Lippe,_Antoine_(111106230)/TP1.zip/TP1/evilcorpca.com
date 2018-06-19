@		IN	SOA	ns1.evilcorpca.com. admin.evilcorpca.com. (
					1		;serial
					604800		; Refresh
					86400		; Retry
					2419200		; Expire
					604800 )	; Negative Cache TTL

		IN	NS	ns1
		IN	NS	ns2
		IN	MX	10 webmail
		IN	MX	20 courriel
evilcorpca.com.	IN	A	199.48.22.99
secure		IN	A	199.48.22.100
webmail		IN	A	199.48.22.36
courriel	IN	A	199.48.22.36
vpn		IN	A	199.48.22.77
evilcorpca.ca.	IN	CNAME	evilcorpca.com.
