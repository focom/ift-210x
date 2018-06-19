@				IN	SOA	ns1.evilcorpca.com.	DNSMaster.evilcorpca.com.	(
						30000
						8H
						2H
						1W
						2D )
;
				IN	NS	ns1
				IN	NS	ns2
				IN	MX	10 courriel
				IN	MX	20 courriel.evilcorp.ca.
ns1				IN	A	199.48.22.28
ns2				IN	A	199.48.22.98
courriel			IN	A	199.48.22.55
webmail				IN	CNAME	courriel
vpn				IN	A	199.48.22.77
www				IN	A	199.48.22.99
www.evilcorp.ca.		IN	CNAME	www	
