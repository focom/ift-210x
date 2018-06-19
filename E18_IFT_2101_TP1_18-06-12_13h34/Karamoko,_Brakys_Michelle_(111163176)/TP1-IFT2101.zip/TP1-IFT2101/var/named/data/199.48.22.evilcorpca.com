$TTL 86400
@    	IN  SOA     ns1.evilcorpca.com. admin.evilcorpca.com. (
            		    2018060610  ;Serial
            		    3600        ;Refresh
            		    1800        ;Retry
            		    604800      ;Expire
            		    86400       ;Minimum TTL
)

;Serveurs dns

	IN	NS		ns1.evilcorpca.com.
  	IN	NS		ns2.evilcorpca.com.
 	IN	PTR		evilcorpca.com.

ns1	IN	A		199.48.22.28
ns2	IN	A		199.48.22.98


;Enregistrements PTR

28	IN	PTR		ns1.evilcorpca.com.
98	IN	PTR		ns2.evilcorpca.com.
36	IN	PTR		webmail.evilcorpca.com.
55	IN	PTR		courriel.evilcorpca.com.
77	IN	PTR		vpn.evilcorpca.com.
99	IN	PTR		www.evilcorpca.com.
100	IN	PTR		secure.evilcorpca.com.

40	IN	PTR		client.evilcorpca.com. ;Definition Serveur client inventé

