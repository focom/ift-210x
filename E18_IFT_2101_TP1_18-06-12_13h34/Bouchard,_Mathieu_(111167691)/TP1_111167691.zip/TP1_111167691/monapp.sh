#!/bin/bash

#*************************************************************
# Fichier :		monapp.sh
# Projet : 		TP1
# Auteur(s) : 	Mathieu Bouchard
# Groupe : 
# Cours : 		Protocoles et technologies internet
# École : 		Université Laval
# Session : 	Été 2018
# Notes : 		
#*************************************************************

#*************************************************************
# Fonction :	fonction_top
# Objectif :	Fonction du sous-menu système
#				Affiche les processus en exécution et le détail des threads
# Notes : 		
#*************************************************************
function fonction_top {
	top -H
}

#*************************************************************
# Fonction :	fonction_crond
# Objectif :	Fonction du sous-menu système
#				Affiche la liste des fichiers ouverts par le service crond
# Notes : 		
#*************************************************************
function fonction_crond {
	clear
	echo "Les fichiers ouverts par le service crond sont les suivants : "
	lsof -c crond
	echo "Appuyez sur une touche pour revenir au menu précédent "
	read
}

#*************************************************************
# Fonction :	sockets_en_ecoute
# Objectif :	Fonction du sous-menu réseau
#				Liste tous les ports en écoute sur le serveur
# Notes : 		
#*************************************************************
function sockets_en_ecoute {
	clear
	netstat -l | grep LISTENING
	echo "Appuyez sur une touche pour revenir au menu précédent "
	read
}

#*************************************************************
# Fonction :	sockets_distants
# Objectif :	Fonction du sous-menu réseau
#				Demande une adresse IP et affiche la liste des ports qui y sont ouverts
# Notes : 		
#*************************************************************
function sockets_distants {
	clear
	echo "Entrez l'adresse IPv4 de la machine à interroger : "
	read adresse
	port_debut=1
	port_fin=65535
	for ((port=$port_debut; port<=$port_fin; port++))
	do
		(echo >/dev/tcp/$adresse/$port) >/dev/null 2>&1 &&echo "$port ouvert"
	done
	echo "Appuyez sur une touche pour revenir au menu précédent "
	read
}

#*************************************************************
# Fonction :	page_distante
# Objectif :	Fonction du sous-menu réseau
#				Demande une adresse IP et va y quérir une page web pour en afficher le contenu
# Notes : 		
#*************************************************************
function page_distante {
	clear
	echo "Entrez l'adresse IPv4 à interroger : "
	read adresse
	lwp-request -m GET $adresse
	echo "Appuyez sur une touche pour revenir au menu précédent "
	read
}

#*************************************************************
# Fonction :	serveur_de_noms
# Objectif :	Fonction du sous-menu réseau
#				Demande un nom de domaine et affiche le serveur DNS autoritaire pour celui-ci
# Notes : 		
#*************************************************************
function serveur_de_noms {
	clear
	echo "Entrez le nom de domaine pour lequel vous désirez obtenir le serveur de noms : "
	read domaine
	echo "Le serveur DNS autoritaire de $domaine est : "
	dig SAO $domaine +short
	echo "Appuyez sur une touche pour revenir au menu précédent "
	read
}

#*************************************************************
# Fonction :	serveur_courriel
# Objectif :	Fonction du sous-menu réseau
#				Demande un nom de domaine et affiche le serveur courriel de celui-ci
# Notes : 		
#*************************************************************
function serveur_courriel {
	clear
	echo "Entrez le nom de domaine pour lequel vous désirez obtenir le serveur courriel : "
	read domaine
	echo "Le serveur courriel de $domaine est : "
	dig MX $domaine +short
	echo "Appuyez sur une touche pour revenir au menu précédent "
	read
}

#*************************************************************
# Fonction :	utilisation_disque
# Objectif :	Fonction du sous-menu disque
#				Affiche toutes les statistiques de l'utilisation du disque en Ko de tous les fichiers du dossier /etc. Permet un affichage page par page.
# Notes : 		
#*************************************************************
function utilisation_disque {
	clear
	lsof +D /etc | less -M
}

#*************************************************************
# Fonction :	systeme_fichier
# Objectif :	Fonction du sous-menu disque
#				Affiche les informations du système de fichiers en 6 colonnes de 1024 octets lisible pour les humains.
# Notes : 		
#*************************************************************
function systeme_fichier {
	clear	
	df -P --block-size=1024 /
	echo "Appuyez sur une touche pour revenir au menu précédent "
	read
}

#*************************************************************
# Fonction :	special_un
# Objectif :	Fonction du sous-menu spécial
#				À déterminer
# Notes : 		
#*************************************************************
function special_un {
	clear
	echo "Cette fonction liste tous les répertoires de la racine et leur taille :"
	du -ha --max-depth=1 /
	echo "Appuyez sur une touche pour revenir au menu précédent "
	read
}

#*************************************************************
# Fonction :	sortie_script
# Objectif :	Fonction du menu principal
#				Affiche un message à l'utilisateur, attend 2 secondes, puis quitte le script
# Notes : 		
#*************************************************************
function sortie_script {
	echo "Merci d'avoir utiliser monapp."
	echo "À bientôt!"
	sleep 2
	clear
	exit
}

#*************************************************************
# Fonction :	sousmenu_systeme
# Objectif :	Affichage et appel des fonctions du sous-menu système
# Notes : 		
#*************************************************************
function sousmenu_systeme {
	while :
	do
		clear
		echo "SOUS-MENU SYSTÈME"
		echo "Choisissez parmi les options suivantes :"
		echo -e "\t 1 \t Afficher les processus en exécution et les détails des threads \n"
		echo -e "\t 2 \t Afficher les fichiers ouverts par le service crond \n"
		echo -e "\t 3 \t Retour au menu principal\n"
		echo -e "Votre choix : \c "
		read choix
		
		case $choix in
			1)  fonction_top ;;
			2)  fonction_crond ;;
			3)  return ;;
			*) 	echo "Vous avez entré une valeur invalide."
				echo "Essayez de nouveau."
				sleep 2 ;;
		esac
	done
}

#*************************************************************
# Fonction :	sousmenu_reseau
# Objectif :	Affichage et appel des fonctions du sous-menu réseau
# Notes : 		
#*************************************************************
function sousmenu_reseau {
	while :
	do
		clear
		echo "SOUS-MENU RÉSEAU"
		echo "Choisissez parmi les options suivantes :"
		echo -e "\t 1 \t Sockets en écoute localement \n"
		echo -e "\t 2 \t Sockets ouverts distants \n"
		echo -e "\t 3 \t Afficher une page distante \n"
		echo -e "\t 4 \t Obtenir serveur de noms \n"
		echo -e "\t 5 \t Obtenir serveur courriel \n"
		echo -e "\t 6 \t Retour au menu principal\n"
		echo -e "Votre choix : \c "
		read choix
		
		case $choix in
			1)  sockets_en_ecoute ;;
			2)  sockets_distants ;;
			3)  page_distante ;;
			4)  serveur_de_noms ;;
			5)  serveur_courriel ;;
			6)  return ;;
			*) 	echo "Vous avez entré une valeur invalide."
				echo "Essayez de nouveau."
				sleep 2 ;;
		esac
	done
}

#*************************************************************
# Fonction :	sousmenu_disque
# Objectif :	Affichage et appel des fonctions du sous-menu disque
# Notes : 		
#*************************************************************
function sousmenu_disque {
	while :
	do
		clear
		echo "SOUS-MENU DISQUE"
		echo "Choisissez parmi les options suivantes :"
		echo -e "\t 1 \t Utilisation du disque \n"
		echo -e "\t 2 \t Système de fichiers \n"
		echo -e "\t 3 \t Retour au menu principal\n"
		echo -e "Votre choix : \c "
		read choix
		
		case $choix in
			1)  utilisation_disque ;;
			2)  systeme_fichier ;;
			3)  return ;;
			*) 	echo "Vous avez entré une valeur invalide."
				echo "Essayez de nouveau."
				sleep 2 ;;
		esac
	done
}

#*************************************************************
# Fonction :	sousmenu_special
# Objectif :	Affichage et appel des fonctions du sous-menu special
# Notes : 		
#*************************************************************
function sousmenu_special {
	while :
	do
		clear
		echo "SOUS-MENU SPECIAL"
		echo "Choisissez parmi les fonctions suivantes :"
		echo -e "\t 1 \t Fonction spéciale"
		echo -e "\t 2 \t Retour au menu principal"
		echo -e "Votre choix : \c "
		read choix
		
		case $choix in
			1)  special_un ;;
			2)  return ;;
			*) 	echo "Vous avez entré une valeur invalide."
				echo "Essayez de nouveau."
				sleep 2 ;;
		esac
	done
}

#*************************************************************
# Fonction :	menu_principal
# Objectif :	Affichage et appel des fonctions du menu principal
# Notes : 		
#*************************************************************
function menu_principal {
	while :
	do
		clear
		echo "MENU PRINCIPAL"
		echo "Entrez le numéro de sous-menu désiré :"
		echo -e "\t 1 \t Sous-menu système"
		echo -e "\t 2 \t Sous-menu réseau"
		echo -e "\t 3 \t Sous-menu disque"
		echo -e "\t 4 \t Sous-menu spécial"
		echo -e "\t 5 \t Quitter"
		echo -e "Votre choix : \c "
		read choix
		
		case $choix in
			1)  sousmenu_systeme ;;
			2)  sousmenu_reseau ;;
			3)  sousmenu_disque ;;
			4)  sousmenu_special ;;
			5) 	sortie_script ;;
			*) 	echo "Vous avez entré une valeur invalide."
				echo "Essayez de nouveau."
				sleep 2 ;;
		esac
	done
}

#*************************************************************
# Fonction :
# Objectif :	Appel du menu principal
# Notes :
#*************************************************************
menu_principal
