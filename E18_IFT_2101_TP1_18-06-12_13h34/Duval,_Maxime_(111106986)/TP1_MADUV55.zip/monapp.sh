#Application en mode console(Script bash)
#Dans le cadres du cours IFT-2101
#Par Maxime Duval

#Affichage du menu principal.
show_mainMenu()
{
	clear
	echo "Bienvenue dans monApp."
	echo "1-Systeme"
	echo "2-Reseau"
	echo "3-Disque"
	echo "4-Custom" 
	echo "5-Quitter"
}

#Lis la valeur fournis par l'utilisateur pour le menuPrincipal.
read_optionsMenu()
{
	local choix
	read -p "Enter votre choix [1-5] : " choix
	case $choix in
		1) menuSysteme ;;
		2) menuReseau ;;
		3) menuDisque ;;
		4) menuCustom ;;
		5) actionQuitter ;;
		*) echo "$(tput setaf 1) Erreur... Recommencer SVP...$(tput sgr 0)" && sleep 2
	esac
}

#Affichage du menu 1-Système
menuSysteme()
{
	clear
	echo "Sous-Menu Systeme"
	echo "1-top : Affiche les processus en execution"
	echo "2-crond : Affiche la liste des fichiers ouverts"
	echo "3-Retour au menu"

	local choix
	read -p "Enter votre choix [1-3] : " choix
	case $choix in
		1) top -H ;;
		2) sousMenuSysteme2 ;;
		3) show_mainMenu ;;
		*) echo "$(tput setaf 1) Erreur... Recommencer SVP...$(tput sgr 0)" && sleep 2
	esac 
}

#Commandes pour l'option 2 du menu Système
sousMenuSysteme2()
{
	clear
	ls -la /etc/cron.daily/
	pause
}

#Affichage du menu 2-Réseau
menuReseau()
{
	clear
	echo "Sous-Menu Reseau"
	echo "1-Socket en écoute (LISTENING)"
	echo "2-Socket ouvert (Distant)"
	echo "3-Page distant"
	echo "4-Serveur de nom"
	echo "5-Serveur de courriel"
	echo "6-Retour au menu"

	local choix
	read -p "Enter votre choix [1-6] : " choix
	case $choix in
		1) netstat -lx ;;
		2) sousMenuReseau2 ;;
		3) sousMenuReseau3 ;;
		4) sousMenuReseau4 ;;
		5) sousMenuReseau5 ;;
		6) show_mainMenu ;;
		*) echo "$(tput setaf 1) Erreur... Recommencer SVP...$(tput sgr 0)" && sleep 2
	esac 
}

#Fonction qui demande d'appuyer sur un touche pour continuer
pause()
{
	read -p "Appuyer sur une touche pour continuer.."
}

#Commande pour l'option 2 du menu Reseau
sousMenuReseau2()
{
	clear
	local ip
	echo "Adresse IPv4 Requise!"
	read -p "Inscrire une adresse IPv4 : " ip
	nmap $ip --allports
	pause 
}

#Commande pour l'option 3 du menu Reseau
sousMenuReseau3()
{
	clear
	local ip
	echo "Adresse IPv4 Requise!"
	read -p "Inscrire une adresse IPv4 : " ip
	pause 
}

#Commande pour l'option 4 du menu Reseau
sousMenuReseau4()
{
	clear
	local webSite
	echo "Adresse Web Requise!"
	read -p "Inscrire une adresse Web (WWW) : " webSite
	dig -t NS $webSite
	pause
}

#Commande pour l'option 5 du menu Reseau
sousMenuReseau5()
{
	clear
	local webSite
	echo "Adresse Web Requise!"
	read -p "Inscrire une adresse Web (WWW) : " webSite
	dig -t MX $webSite
	pause
}

#Affichage du menu 3-Disque
menuDisque()
{
	clear
	echo "Sous-Menu Disque"
	echo "1-Utilisation (Stats de l'utilisation du disque)"
	echo "2-Fichiers (Informations du systeme de fichiers)"
	echo "3-Retour au menu"

	local choix
	read -p "Enter votre choix [1-3] : " choix
	case $choix in
		1) du -akh /etc | less ;;
		2) sousMenuDisque2 ;;
		3) show_mainMenu ;;
		   
		*) echo "$(tput setaf 1) Erreur... Recommencer SVP...$(tput sgr 0)" && sleep 2
	esac 
}

sousMenuDisque2()
{	
	clear
	df -kh
	pause
}

#Affichage du menu 4-Custom
menuCustom()
{
	clear
	echo "Sous-Menu Custom"
	echo "1-Redémarrer le poste de travail"
	echo "2-Fermer le poste de travail"
	echo "3-Affichage des répertoires sous un arbre"
	echo "4-Trouver le nombre"
	echo "5-Retour au menu"

	local choix
	read -p "Enter votre choix [1-5] : " choix
	case $choix in
		1) /sbin/shutdown -r now ;;
		2) /sbin/shutdown -h now ;;
		3) sousMenuCustom3 ;;
		4) sousMenuCustom4 ;;
		5) show_mainMenu ;;		   
		*) echo "$(tput setaf 1) Erreur... Recommencer SVP...$(tput sgr 0)" && sleep 2
	esac 
}
#Commandes pour l'option 3 du menu Custom
sousMenuCustom3()
{	
	clear
	echo "Il faut faire l'installation du package (yum install tree -y)"
	tree -a > /root/Bureau/Arbres.txt
	echo "Le fichier TXT est sur le bureau"
	pause
}
#Commandes pour l'option 4 du menu Custom
sousMenuCustom4()
{	
	clear
	r=$(( $RANDOM % 10))
	echo "Vous avez 1 seul chance pour trouver le nombre choisi au hazard!"
	local choix
	read -p "Enter votre chiffre [0-9] : " choix	
	case $choix in
		$r) echo "Félicitations! Vous avez trouvé le nombre!" ;;
		*) echo "Désolé, ce n'est pas le bon nomre." ;;
	esac
	pause
}
#Menu Quitter
actionQuitter()
{
	echo Au Revoir, à bientot! 
	sleep 2 #Pause de 2 secondes
	clear
	exit
}

#Action principale. (Lancé à l'exécution)
	clear
	while true
	do
		show_mainMenu
		read_optionsMenu
	done







