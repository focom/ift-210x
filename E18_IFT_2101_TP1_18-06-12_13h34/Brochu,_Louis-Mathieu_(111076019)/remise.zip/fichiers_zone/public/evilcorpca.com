@         IN   SOA    ns1.evilcorpca.com. DNSMaster.ns1.evilcorpca.com. (
2000101804             ; serial, date + #seq
8H                     ; refresh, 8 heures
2H                     ; retry,   2 heures
1W                     ; expire,  1 semaine
1D )                   ; minimum, 1 jour
;
	IN 	NS 	ns1
	IN 	NS 	ns2
	IN	MX	10	courriel
www IN	A	199.48.22.99  
ns1	IN	A 	199.48.22.28
ns2	IN	A 	199.48.22.98
courriel IN A 199.48.22.55
courriel IN A 199.48.22.36 
webmail IN CNAME courriel
secure IN A 199.48.22.100
vpn IN A 199.48.22.77 
monserveur IN A 199.48.22.78
