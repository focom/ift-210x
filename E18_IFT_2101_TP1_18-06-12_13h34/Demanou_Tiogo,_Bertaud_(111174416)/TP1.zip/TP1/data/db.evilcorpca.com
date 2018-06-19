$TTL 604800     ; 1 semaine
$ORIGIN evilcorpca.com.
@       IN      SOA     ns1.evilcorpca.com. admin.evilcorpca.com. (
                              3         ; Serial
             604800     ; Refresh
              86400     ; Retry
            2419200     ; Expire
             604800 )   ; Negative Cache TTL
;
;  name servers - NS records
 	IN 	NS	ns1.evilcorpca.com.
 	IN 	NS 	ns2.evilcorpca.com.

;  name servers - MX records
 	IN 	MX 10	courriel.evilcorpca.com.

; name servers - A records

ns1.evilcorpca.com.			IN	A	199.48.22.28		
ns2.evilcorpca.com.			IN	A	199.48.22.98
courriel.evilcorpca.com.		IN	A	199.48.22.55

; 199.48.22.0/24 - A records

vp.evilcorpca.com.		IN	A	199.48.22.77
webmail.evilcorpca.com.		IN	A	199.48.22.36
courriel.evilcorpca.com.	IN	A	199.48.22.36
secure.evilcorpca.com.		IN	A	199.48.22.100
www.evilcorpca.com.		IN	A	199.48.22.99



