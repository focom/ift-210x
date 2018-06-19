$TTL		86400
@			IN	SOA		ns1.evilcorpca.com.	DNSmaster.evilcorpca.com. (
						2018050901			; serial, date + #seq
						8H					; refresh
						2H					; retry
						1W					; expire
						1D)					; minimum
;
			IN	TXT		"Bienvenue chez EvilCorp"
			IN	HINFO	"Machine virtuelle" "CentOS 7"
			IN	NS		ns1					; serveur DNS primaire
			IN	NS		ns2					; serveur DNS secondaire
			IN	MX		10 courriel			; serveur courriel primaire
localhost	IN	A		127.0.0.1
gw			IN	A		10.10.1.1
			IN	TXT		"La Passerelle"
ns1			IN	A		199.48.22.28
ns2			IN	A		199.48.22.98
courriel	IN	A		199.48.22.55
webmail		IN	A		199.48.22.36
vpn			IN	A		199.48.22.77
secure		IN	A		192.168.100.100