; Fichier pour la zone
@               IN   SOA    ns1.evilcorpca.com.   ns1Master.evilcorpca.com. (
                     2018060301         ; serial, date + #seq
                     8H                 ; refresh, 8 heures
                     2H                 ; retry, 2 heures
                     1W                 ; expire, 1 semaine
                     1D)                ; minimum 1 jour
;

                IN   NS      ns1.evilcorpca.com. ; adresse du dns principal
                IN   NS      ns2.evilcorpca.com. ; adresse du dns secondaire
                IN   MX      10 courriel         ; courriel
passerelle      IN   A       10.10.1.1           ; passerelle local
fichiers        IN   A       10.10.1.89          ; fichier interne
vpn             IN   A       199.48.22.77        ; vpn
webmail         IN   A       199.48.22.36        ; courriel en ligne
ns1		IN   A       199.48.22.28	 ; dns principal
ns2		IN   A       199.48.22.98	 ; dns secondaire
courriel	IN   A       199.48.22.55	 ; courriel
evilcorpca.com.	IN   A       199.48.22.99	 ; adresse internet
evilcorp.ca.	IN   CNAME   evilcorpca.com.     ; adresse redirigée
secure		IN   A	     199.48.22.100       ; adresse DMZ
paye		IN   A       10.10.1.2	         ; système de paye des employés

; Le serveur paye est local et permet aux employés de voir leurs informations
; salariales.Voir l'adressage inverse dans le fichier domaine local.
