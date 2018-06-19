@         IN   SOA    ns2.evilcorpca.com. ns1.evilcorpca.com. ( 
                      2000101804             ; serial, date + # sequentiel 
                      8H                     ; refresh, 8 heures 
                      2H                     ; retry,   2 heures 
                      1W                     ; expire,  1 semaine 
                      1D )                   ; minimum, 1 jour 
; 
          IN   NS     ns1                    ; Adresse du DNS primaine
          IN   NS     ns2                    ; Adresse du DNS secondaire
; 
          IN   MX     10 courriel            ; Primaire Mail Exchanger 
          IN   MX     20 courriel.evilcorpca.com ; Secondaire Mail Exchanger 
; 
ns1       IN   A      199.48.22.28 
ns2       IN   A      199.48.22.98
courriel  IN   A      199.48.22.55
www	  IN   A      199.48.22.99
vpn       IN   A      199.48.22.77
secure    IN   A      199.48.22.100
webmail	  IN   A      199.48.22.36
courriel.evilcorpca.com IN CNAME webmail
evilcorp.ca IN CNAME  www
