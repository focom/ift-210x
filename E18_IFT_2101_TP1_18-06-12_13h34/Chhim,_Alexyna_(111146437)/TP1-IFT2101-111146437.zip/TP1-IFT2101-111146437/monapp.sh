#***************************************************
# Fichier : tp1
# Projet : TP1
# Auteur : Alexyna Chhim (111 146 437)
# Groupe :
# Cours : Protocoles et technologies Internet
# École : Université Laval
# Session : Été 2018
# Notes : 
#***************************************************

#***************************************************
# Fonction : systeme
# Objectif : Affiche et exécute le sous-menu Système
#***************************************************
function systeme
{
while :
do
	clear
	echo -e "SOUS-MENU SYSTÈME \n"
	echo -e "\t Option \t Description \n"
	echo -e "\t 1 \t\t Afficher les processus en exécution"
	echo -e "\t 2 \t\t Afficher les fichiers ouverts par le service crond"
	echo -e "\t 3 \t\t Revenir au menu principal \n"
	echo -e "Votre choix : "
	read choixSysteme
	
	case $choixSysteme in
		1) top -H ;;
		2) crontab -l
		   sleep 5 ;;
		3) break ;;
	esac
done  
}

#***************************************************
# Fonction : reseau
# Objectif : Affiche et exécute le sous-menu Réseau
#***************************************************
function reseau
{
while : 
do
	clear
	echo -e "SOUS-MENU RÉSEAU \n"
	echo -e "\t Option \t Description \n"
	echo -e "\t 1 \t\t Lister tous les ports ouverts en écoute sur le serveur"
	echo -e "\t 2 \t\t Afficher tous les ports ouverts à une adresse IP"
	echo -e "\t 3 \t\t Afficher le contenu HTML d'une adresse IP"
	echo -e "\t 4 \t\t Afficher le serveur DNS authoritaire pour un nom de domaine"
	echo -e "\t 5 \t\t Afficher le serveur qui reçoit les courriels pour un nom de domaine"
	echo -e "\t 6 \t\t Revenir au menu principal \n" 
	echo -e "Votre choix : "	
	read choixReseau

	case $choixReseau in 
		1) netstat -l | grep LISTENING
		   sleep 5 ;; 
		2) echo "Entrez une adresse IP : "
		   read adresse
		   netstat -ln | grep $adresse
		   sleep 5 ;;
		3) echo "Entrez une adresse IP : "
		   read adresseIP
		   GET $adresseIP
		   sleep 5 ;; 
		4) echo "Entrez un nom de domaine : "
		   read domaine
		   host -t ns $domaine
		   sleep 5 ;;
		5) echo "Entrez un nom de domaine : "
		   read domaineEmail
		   nslookup -query=mx $domaineEmail | grep mail
		   sleep 5 ;;
		6) break ;; 
	esac
done     
}
#***************************************************
# Fonction : disque
# Objectif : Affiche et exécute le sous-menu Disque
#***************************************************
function disque
{
while :
do
	clear
	echo -e "SOUS-MENU DISQUE \n"
	echo -e "\t Option \t Description \n"
	echo -e "\t 1 \t\t Afficher les statistiques de l'utilisation du disque de /etc"
	echo -e "\t 2 \t\t Afficher les informations du système de fichiers" 
	echo -e "\t 3 \t\t Revenir au menu principal \n"
	echo -e "Votre choix : \c"
	read choixDisque
	
	case $choixDisque in
		1) du -all /etc
		   sleep 5 ;;
		2) ls -hkl
		   sleep 5 ;;
		3) break ;;
	esac
done 
}

#***************************************************
# Fonction : quitter
# Objectif : Termine le script
#***************************************************
function quitter
{
clear
echo "AU REVOIR ET BONNE JOURNÉE!" 
sleep 2
clear
exit
}

#***************************************************
# Fonction : dateCalendrier
# Objectif : Affiche et exécute le sous-menu Date et Calendrier
#***************************************************
function dateCalendrier
{
while :
do 
	clear
	echo -e "SOUS-MENU DATE \n"
	echo -e "\t Option \t Description \n"
	echo -e "\t 1 \t\t Afficher la date et l'heure"
	echo -e "\t 2 \t\t Afficher le calendrier"
	echo -e "\t 3 \t\t Calculer votre age"
	echo -e "\t 4 \t\t Revenir au menu principal \n"
	echo -e "Votre choix : "
	read choixDate

	case $choixDate in
		1) date
		   sleep 5 ;;
		2) cal -3 
		   sleep 5 ;;
		3) echo "Quelle est votre date de naissance (AAAA-MM-JJ) ? : "
		   read dateNaissance
		   aujourdhui=$(date +%Y-%m-%d) 
		   tempJours=$(printf '%s' $(( $(date -u -d"$aujourdhui" +%s) - $(date -u -d"$dateNaissance" +%s))))
		   age=$((tempJours / 60 / 60 / 24 / 364))
		   echo "Vous avez $age ans."
		   sleep   5 ;; 
		4) break ;;
	esac
done
}

#***************************************************
# Fonction :
# Objectif : Boucle du menu principal
#***************************************************
while :
do
	clear
	echo -e "MENU PRINCIPAL \n"
	echo -e "\t Option \t Description \n"
	echo -e "\t 1 \t\t Système"
	echo -e "\t 2 \t\t Réseau"
	echo -e "\t 3 \t\t Disque"
	echo -e "\t 4 \t\t Date et Calendrier "
	echo -e "\t 5 \t\t Quitter \n"
	echo -e "Votre choix : " 
	read choixMPrincipal
	
	case $choixMPrincipal in 
		1) systeme ;;
		2) reseau ;;
		3) disque ;;
		4) dateCalendrier ;;
		5) quitter ;;
	esac
done
		
