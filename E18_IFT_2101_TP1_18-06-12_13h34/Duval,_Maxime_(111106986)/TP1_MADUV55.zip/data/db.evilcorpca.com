$ORIGIN evilcorp.ca.
$TTL 86400 ; Durée maximale du cache.
@       IN      SOA     ns1.evilcorpca.com. admin.evilcorpca.com. (
                     	      1         ; Numéro de série. (Serial)
                           3600         ; Rafraîchissement. (Refresh)
                            900         ; Nouvelle tentative. (Retry)
                        1209600         ; Expiration. (Expire)
                          86400 )       ; Durée cache minimum. (TTL Minimum)

;------------------------
; Enregistrements NS.
;------------------------
; Serveurs de noms.
@                                   IN      NS       ns1.evilcorpca.com.
@                                   IN      NS       ns2.evilcorpca.com.

;------------------------
; Enregistrements MX.
;------------------------
; Serveurs de messageries.
@                                   IN      MX       10       mx01.evilcorpca.com.
@                                   IN      MX       20       mx02.evilcorp.ca.

;------------------------
; Enregistrements A.
;------------------------
;Passerelle interne
passerelle.evilcorpca.local	  IN	  A	10.10.1.1

; Serveurs de noms.
ns1.evilcorpca.com.               IN      A        199.48.22.28
ns2.evilcorpca.com.               IN      A        199.48.22.98

; Serveurs de messageries.
mx01.evilcorpca.com.            IN      A        199.48.22.55
mx02.evilcorp.ca.               IN      A        199.48.22.55

; Sous-domaines.
fichiers.evilcorpca.local	    IN      A        10.10.1.89
webmail.evilcorpca.com.             IN      A        199.48.22.36
courriel.evilcorpca.com.            IN      A        199.48.22.36
vpn.evilcorpca.com.	            IN      A        199.48.22.77
evilcorpca.com.                     IN      A        199.48.22.99

;------------------------
; Enregistrements CNAME.
;------------------------
; Alias.
www                                 IN      CNAME    evilcorpca.com.
www                                 IN      CNAME    evilcorp.ca.
ftp                                 IN      CNAME    fichiers.evilcorpca.local.
pop                                 IN      CNAME    webmail.evilcorpca.com.
pop                                 IN      CNAME    courriel.evilcorpca.com.

