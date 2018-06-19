; ZONE DOMAINE (INTERNE)
;
@       IN      	SOA     ns1.evilcorpca.com. DNSMaster.evilcorpca.com. (
							2018060201       ; serial#, date 2 juin 2018
							3H      ; Refresh period
							1H      ; Retry refresh
							1W      ; Expire period
							1D )    ; Minimum TTL
;
							 IN      NS      ns1.evilcorpca.com.
		 					 IN      NS      ns2.evilcorpca.com.
;
@							 IN      A       199.48.22.99		; addresse IPv4 pour evilcorpca.com
evilcorpca.ca.               IN      CNAME   evilcorpca.com.	; evilcorpca.ca est un alias pour evilcorpca.com
www             		 	 IN      CNAME   evilcorpca.com.	; www est un alias pour evilcorpca.com
;
							 MX      10 courriel        		; Primary Mail Exchanger
							 MX      20 courriel        		; Secondary Mail Exchanger 
courriel             	     IN	     A       199.48.22.55		; courriel.evilcorpca.com
webmail               		 IN      CNAME   courriel 			; webmail est un alias pour courriel
;
web             	         IN	     A       199.48.22.36       ; passerelle public Web
;
paiement		     		 IN	     A       199.48.22.100      ; passerelle public paiement 
;
vpn          				 IN  	 A       199.48.22.77		; vpn.evilcorpca.com.
;
ns1          				 IN      A       199.48.22.28		; Primary name server
ns2          				 IN      A       199.48.22.98		; Secondary name server
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DMZ
secure		             	 IN	     A       192.168.100.100    ; passerelle de paiement (DMZ) (secure.evilcorpca.com)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Intranet
localhost                    IN      A       127.0.0.1			; loopback adress
fichier	             	 	 IN	     A       10.10.1.89         ; Serveur fichier interne (fichier.evilcorpca.local)
passerelle	             	 IN	     A       10.10.0.1          ; Passerelle interne (passerelle.evilcorpca.local)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



