@ IN SOA  ns1.evilcorpca.com. dnsadmin.evilcorpca.com. ( 
         1      ;serial (version) 
         3H     ;refresh period 
         15M    ;retry refresh this often 
         1W     ;expiration period 
         1D     ;minimum TTL 
         )
	
@	IN NS ns1.evilcorpca.com.
ns1.evilcorpca.com. 	IN A 199.48.22.28

@	IN NS ns2.evilcorpca.com.	
ns2.evilcorpca.com.	IN A 199.48.22.98

www.evilcorpca.com.	IN A 199.48.22.99

secure.evilcorpca.com. IN A 199.48.22.100

courriel.evilcorpca.com. IN A 199.48.22.55
evilcorpca.com.  IN MX 10 courriel.evilcorpca.com.

webmail.evilcorpca.com. IN A 199.48.22.36

vpn.evilcorpca.com.	IN A 199.48.22.77

db.evilcorpca.com. IN A 199.48.22.7
 



