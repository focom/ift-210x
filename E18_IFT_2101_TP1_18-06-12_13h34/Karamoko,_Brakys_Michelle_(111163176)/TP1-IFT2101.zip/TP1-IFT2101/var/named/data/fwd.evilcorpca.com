$TTL 86400
@   	IN  SOA     ns1.evilcorpca.com.  admin.evilcorpca.com. (
                            2018060610  ;Serial
            		    3600        ;Refresh
            		    1800        ;Retry
            		    604800      ;Expire
              		    86400       ;Minimum TTL
)

;Serveurs dns

   		IN	NS		ns1.evilcorpca.com.
   		IN	NS		ns2.evilcorpca.com.
	

;Serveurs de courriel

	        IN 	MX  	10 	courriel
		IN 	MX	15	webmail


ns1		IN	A	199.48.22.28
ns2		IN	A	199.48.22.98
courriel	IN 	A	199.48.22.55
webmail		IN	A	199.48.22.36
vpn		IN	A	199.48.22.77
www		IN 	A	199.48.22.99
secure		IN	A	199.48.22.100

client		IN	A	199.48.22.40  ;Definition Serveur client inventé


evilcorp.ca  			IN	CNAME		www
