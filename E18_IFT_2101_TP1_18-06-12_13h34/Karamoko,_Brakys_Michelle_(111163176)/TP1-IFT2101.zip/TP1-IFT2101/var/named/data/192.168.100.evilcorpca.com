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


;Enregistrements PTR

100	IN	PTR		secure.evilcorpca.com.


