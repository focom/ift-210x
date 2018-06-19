#!/bin/bash
#-------------------------------------------------------#
#	Fichier : monapp.sh				#
#	Projet	: Travail pratique #1 - Question 1	#
#	Auteur	: Jimmy Lapointe Mélançon (111 071 739)	#
#	Cours	: IFT-2101				#
#	École	: Université Laval			#
#	Session	: Été 2018				#
#-------------------------------------------------------#

#=======================================================

#-------------------------------------------------------#
#	Fonction : MenuPrincipal			#
#	Objectif : Afficher/Retourner au menu principal	#
#	Notes	 : N\A					#
#-------------------------------------------------------#
function MenuPrincipal()
{
	clear
	echo -e "BIENVENUE DANS LE MENU PRINCIPAL \n"
	echo -e "FAITES UN CHOIX PARMIS LES CATÉGORIES SUIVANTES: \n"
	echo -e "1-Système \n"
	echo -e "2-Réseau \n"
	echo -e "3-Disque \n"
	echo -e "4-Gestion supplémentaire du serveur \n"
	echo -e "5-Quitter \n"
	echo -e "-------------------- \n"

	read -p "Votre choix : " choixMenuPrincipal
	
	case $choixMenuPrincipal in
		1) 
			MenuSysteme ;;
		2) 
			MenuReseau ;;
		3) 
			MenuDisque ;;
		4) 
			MenuGestionSupReseau ;;
		5)
			Quitter ;;
		*)
			echo -e "Le paramètre saisi est incorrecte."
			sleep 1
			MenuPrincipal
			;;
	esac
}

#-----------------------------------------------#
#	Fonction : MenuSysteme			#
#	Objectif : Affiche le menu système	#
#	Notes	 : N\A				#
#-----------------------------------------------#
function MenuSysteme()
{
	clear
	MessageAcceuil 'SYSTÈME'
	echo -e "1- top: affiche les processus en exécution ainsi que le détail des threads \n"
	echo -e "2- crond : affiche la liste des fichiers ouverts par le service crond \n"
	echo -e "3- Retour au menu principal \n"
	echo -e "-------------------- \n"
	
	read -p "Votre choix : " choixMenuSysteme
	
	echo -e "\n\n"
	
	case $choixMenuSysteme in
		1) 
			# H : Affiche l'ensemble des threads de façon individuel
			# n : Détermine le nombre d'itération à faire, ici 1 afin d'avoir une idée momentanée des processus et threads
			top -Hn 1
			MessageRetourMenuPrecedent 'SYSTÈME'
			MenuSysteme
			;;
		2) 
			echo -e "Liste des fichiers ouverts par le service crond :" 
			echo -e "-------------------------------------------------"
			lsof | grep crond || (echo "Aucun fichier n'est présentement ouvert par le service crond." | sleep 1)
			MessageRetourMenuPrecedent 'SYSTÈME'
			MenuSysteme;
			;;
		3)
			MenuPrincipal; ;;
		*)
			echo -e "Le paramètre saisi est incorrecte."
			sleep 1
			MenuSysteme
			;; 
	esac
}

#-----------------------------------------------#
#	Fonction : MenuReseau			#
#	Objectif : Affiche le menu reseau	#
#	Notes	 : N\A				#
#-----------------------------------------------#
function MenuReseau()
{
	clear
	MessageAcceuil 'RÉSEAU'
	echo -e "1- Socket en écoute (LISTENING) local : Liste toute les ports ouverts en écoute sur le serveur \n"
	echo -e "2- Socket ouverts (distant) : Demande une adresse IP et y vérifie et affiche tous les ports qui y sont ouvert \n"
	echo -e "3- Page distante : Demande une adresse IP et va y quérir une page web et affiche son contenu HTML \n"
	echo -e "4- Serveur de noms : Demande un nom de domaine et affiche le serveur DNS autoritaire pour ce nom de domaine \n"
	echo -e "5- Serveur courriel : Demande un nom de domaine et affiche le serveur qui reçoit les courriels pour ce domaine \n"
	echo -e "6- Retour au menu principal \n"
	echo -e "-------------------- \n"
	
	read -rp "Votre choix : " choixMenuReseau 
	
	echo -e "\n\n"
	
	case $choixMenuReseau in
		1) 
			(netstat -l | grep LISTENING) || echo -e "Aucune donnée n'est ressortît pour cette adresse IP ($AdresseIP)" | sleep 1
			MessageRetourMenuPrecedent 'RÉSEAU'
			MenuReseau
			;;
		2) 
			read -p "Adresse IP devant être inspectée : " AdresseIP
			
			# ipcalc permet d'avoir une multitude d'information, dont savoir si l'addresse ip fournît est valide
			# C'est le paramètre -c qui permet de savoir si elle est d'un format valide
			# Le paramètre -s force la commande à rester en 'silent mode', c'est-à-dire qu'elle n'affiche aucune information.
			if $(ipcalc -cs $AdresseIP) 
			then
				# Tente d'afficher le résultat de netstat, mais si aucune donnée n'est affiché, affiche un message en informant l'usager
				(netstat -a | grep $AdresseIP) || (echo -e "\nAucune donnée n'est ressortît pour l'adresse IP : $AdresseIP" | sleep 1)
			else
				echo -e "L'adresse IP fournît est invalide"
				sleep 1
			fi

			MessageRetourMenuPrecedent 'RÉSEAU'
			MenuReseau
			;;
		3) 
			read -p "Adresse IP du site web devant être inspectée : " AdresseIPHTML

			if $(ipcalc -cs $AdresseIPHTML) # Si l'adresse IP est valide
			then			
				# wget permet d'aller chercher le contenu d'un site web, à partir d'un URL ou bien encore d'une adresse IP
				# -q s'assure que wget reste silencieux, qu'il ne m'affiche aucune information à l'écran pendant son fetching du contenu html de l'adresse IP
				# Il est important de noter ici le O-, cette option permet d'afficher directement le contenu HTML du site web, sans avoir à passer par un fichier quelconque 
				wget -qO- $AdresseIPHTML || (echo -e "\nL'adresse IP $AdresseIPHTML semble être associée à aucun site web" | sleep 1)
			else
				echo -e "\nL'adresse IP fournît est invalide"
				sleep 1
			fi
			
			MessageRetourMenuPrecedent 'RÉSEAU'
			MenuReseau
			;;
		4) 
			read -p "Nom du domaine recherché : " NomDomaine
			resultat=$(dig $NomDomaine NS +short)
			if [ -z $resultat ]
			then 
				echo -e "\nAucun résultat retourné par la commande"
				sleep 1
			fi	
			MessageRetourMenuPrecedent 'RÉSEAU'
			MenuReseau
			;;
		5) 
			read -p "Nom du domaine courriel recherché : " NomDomaineCourriel
			resultat=$(dig $NomDomaineCourriel MX +short)
			if [ -z $resultat ]
			then 
				echo -e "\nAucun résultat retourné par la commande"
				sleep 1
			fi			
			MessageRetourMenuPrecedent 'RÉSEAU'
			MenuReseau
			;;
		6)
			MenuPrincipal ;;
		*)
			echo -e "Le paramètre saisi est incorrecte."
			sleep 1
			MenuReseau
			;; 
	esac;
}

#-----------------------------------------------#
#	Fonction : MenuDisque			#
#	Objectif : Affiche le menu disque	#
#	Notes	 : N\A				#
#-----------------------------------------------#
function MenuDisque()
{
	clear
	MessageAcceuil 'DISQUE'
	echo -e "1- Utilisation : Affiche l'ensemble des statistiques de l'utilisation du disque en Ko pour tous les fichiers du dossier /etc. De plus, doit permettre un affichage page par page \n"
	echo -e "2- Fichiers : Affiche les informations du système de fichiers en 6 colonnes par bloc de 1024 octets et que ce soit lisible pour les humains \n"
	echo -e "3- Retour au menu principal \n"
	echo -e "-------------------- \n"
	
	read -p "Votre choix : " choixMenuDisque
	
	echo -e "\n\n"
	
	case $choixMenuDisque in
		1) 
			# k permet d'avoir le résultat en kilobytes
			# x s'assure qu'il ne regarde que les fichiers
			# le | more permet de naviger facilement le contenu du résultat avec soit PgUp/PgDown ou espace/Entrée
			du -kx /etc/ | more
			MessageRetourMenuPrecedent 'DISQUE'
			MenuDisque
			;;
		2) 
			# P force un affichage sur 6 colonnes
			# T affiche le type de chaque système de fichiers
			# k permet d'avoir le résultat en kilobytes
			# h permet d'avoir un résultat lisible par un humain, qui a des bases en informatique bien entendu
			df -PTkh
			MessageRetourMenuPrecedent 'DISQUE'
			MenuDisque
			;;
		3)
			MenuPrincipal ;;
		*)
			echo -e "Le paramètre saisi est incorrecte."
			sleep 1
			MenuDisque
			;; 
	esac;
}

#---------------------------------------------------#
#	Fonction : MenuGestionSupReseau		    #
#	Objectif : Affiche mon menu personnalisé    #
#	Notes	 : N\A				    #
#---------------------------------------------------#
function MenuGestionSupReseau()
{
	clear
	MessageAcceuil 'Gestion supplémentaire du serveur'
	echo -e "1- Permet de connaître les utilisateurs ainsi que leur temps d'inactivité \n"
	echo -e "2- Envoi d'un message à chaque usager afin de les avertir d'une maintenance ou autre \n"
	echo -e "3- Retour au menu principal \n"
	echo -e "-------------------- \n"
	
	read -p "Votre choix : " choixMenuMonMenuPerso
	
	echo -e "\n\n"
		
	case $choixMenuMonMenuPerso in
		1) 
			# H pour une entête
			# u pour afficher le temps d'inactivité d'un utilisateur
			who -Hu 
			MessageRetourMenuPrecedent 'Gestion supplémentaire du serveur'
			MenuGestionSupReseau
			;;
		2) 
			read -p "Message devant être envoyé à l'ensemble des utilisateurs : " TexteMettreSurWall
			
			$(wall $TexteMettreSurWall)
			
			sleep 2
			#read Timeout # Pour ne pas renvoyer toute suite le clear de MenuGestionSupReseau
			MenuGestionSupReseau
			;;
		3)
			MenuPrincipal; ;;
		*)
			echo -e "Le paramètre saisi est incorrecte."
			sleep 1
			MenuGestionSupReseau
			;;
	esac;		
}

#-----------------------------------------------#
#	Fonction : Quitter			#
#	Objectif : "Terminator" du programme	#
#	Notes	 : N\A				#
#-----------------------------------------------#
function Quitter()
{
	ROUGE='\033[0;31m'
	NOIR='\033[0m'
	
	
	echo -e "\n${ROUGE}Skynet${NOIR} vous souhaite une agréable journée!\n\n"
	
	echo -e "\033[0;31m                        ______ 				\033[0m"
	echo -e "\033[0;31m                      <((((((||| 			\033[0m"
	echo -e "\033[0;31m                      /      . }\ 			\033[0m"
	echo -e "\033[0;31m                      ;--..--._|} 			\033[0m"
	echo -e "\033[0;31m  (¯\                 '--/\--'  ) 			\033[0m"
	echo -e "\033[0;31m   \ \                | '-'  :'| 			\033[0m"
	echo -e "\033[0;31m    \ \               . -==- .-| 			\033[0m"
	echo -e "\033[0;31m     \ \               \.__.'   \--._ 		\033[0m"
	echo -e "\033[0;31m     [\ \          __.--|       //  _/'--. 	\033[0m"
	echo -e "\033[0;31m     \ \ \       .'-._ ('-----'/ __/      \ 	\033[0m"
	echo -e "\033[0;31m      \ \ \     /   __>|      | '--.       | \033[0m"
	echo -e "\033[0;31m       \ \ \   |   \   |     /    /       / 	\033[0m"
	echo -e "\033[0;31m        \ ''\ /     \  |     |  _/       / 	\033[0m"
	echo -e "\033[0;31m         \   \       \ |     | /        / 	\033[0m"
	echo -e "\033[0;31m          \   \      \        /        / 	\033[0m"
	echo -e "\033[0;31m           ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ 		\033[0m"
	
	sleep 2
	
	clear
	
	exit 1 # Ferme le programme
}

#---------------------------------------------------#
#	Fonction : MessageAcceuil		    #
#	Objectif : Uniformiser le message d'acceuil #
#	Notes	 : N\A			            #
#---------------------------------------------------#
function MessageAcceuil()
{
	echo -e "BIENVENU DANS LA SECTION $1 \n"
	echo -e "CHOISIR L'UNE DES ACTIONS SUIVANTES: \n"
}

#---------------------------------------------------#
#	Fonction : MessageRetourMenuPrecedent		    #
#	Objectif : Uniformiser le message pour retourner au menu #
#	Notes	 : N\A			            #
#---------------------------------------------------#
function MessageRetourMenuPrecedent()
{
	JAUNE='\033[0;33m'
	NOIR='\033[0m'
	printf "\n\nAppuyez sur la touche [ ${JAUNE}ENTRÉE${NOIR} ] pour revenir au menu $1 ... "
	read "" Timeout
}

#====================================================

MenuPrincipal

