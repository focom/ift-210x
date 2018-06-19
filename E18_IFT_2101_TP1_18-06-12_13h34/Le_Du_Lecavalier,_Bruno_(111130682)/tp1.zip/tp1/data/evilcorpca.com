@              IN    SOA    ns1.evilcorpca.com.     admin.evilcorpca.com. (
                            2000101804
                            8H
                            2H
                            1W
                            1D  )
;

               IN   NS      ns1
               IN   NS      ns2

               IN   MX      10 courriel
courriel       IN   A       199.48.22.55

ns1            IN   A       199.48.22.28
ns2            IN   A       199.48.22.98

@              IN   A       199.48.22.99
secure         IN   A       199.48.22.100
courriel       IN   A       199.48.22.36
vpn            IN   A       199.48.22.77

webmail        IN   CNAME   courriel

