#!/bin/bash

#***************************************
#***************************************
# IFT-2101, ETE-2018, TP1, Question 1
# monapp.sh
# Jean-Philippe Beaulieu
# 111 119 943
#***************************************
#***************************************


#***************************************
#***************************************
# Fonction pour Sous-menu système
function choixSysteme
{
while :
do
	clear
	echo -e "Sous-menu système\n"
	echo -e "\t Option   description \n"
	echo -e "\t 1) \t top: "
	echo -e "\t 2) \t crond: "
	echo -e "\t 3) \t Revenir au menu principal: "
	echo -e "\tVotre choix : \c"
	read choix
	
	case $choix in
	1) choixSystemeUn;;
	2) choixSystemeDeux;;
	3) return;;
	esac
done
}

function choixSystemeUn
{
	clear #Effacer l'écran
	top -H #commande, (-H) afffiche details de threads
	echo -e " \n" #Saute une ligne
	read -rsn1 -p"*** Appuyez sur une touche pour retourner au menu ***" variable;echo #retour au menu
}

function choixSystemeDeux
{
	clear #Effacer l'écran
	cd /etc/cron.d && ls -l;  #commande
	echo -e " \n" #Saute une ligne
	read -rsn1 -p"*** Appuyez sur une touche pour retourner au menu ***" variable;echo #retour au menu
}
#***************************************
#***************************************


#***************************************
#***************************************
# Fonction pour Sous-menu Réseau
function choixReseau
{
while :
do
	clear
	echo -e "Sous-menu Réseau\n"
	echo -e "\t Option   description \n"
	echo -e "\t 1) \t Socket en écoute localement: "
	echo -e "\t 2) \t Socket ouverts distant: "
	echo -e "\t 3) \t Page distante: "
	echo -e "\t 4) \t Serveur de noms: "
	echo -e "\t 5) \t Serveur courriel: "
	echo -e "\t 6) \t Revenir au menu principal: "
	echo -e "\tVotre choix : \c"
	read choix
	
	case $choix in
	1) choixReseauUn;;
	2) choixReseauDeux;;
	3) choixReseauTrois;;
	4) choixReseauQuatre;;
	5) choixReseauCinq;;
	6) return;;
	esac
done
}

function choixReseauUn #Socket en écoute localement
{
	clear #Effacer l'écran
	netstat -l |more;  #commande
}

function choixReseauDeux #Socket ouverts distant
{
	clear #Effacer l'écran
	echo "Entrez un adresse IP: " #Afficher message
	read ipVar #Lecture donnée saisie utilisateur
    nc -n -w 1 $ipVar #commande Netcat, (-n) pas DNS lookout, (-w 1) timeout apres 1 seconde
	echo -e " \n" #Saute une ligne
	read -rsn1 -p"*** Appuyez sur une touche pour retourner au menu ***" variable;echo #retour au menu
}

function choixReseauTrois #Page distante
{
	clear #Effacer l'écran
	clear #Effacer l'écran
	echo "Entrez un adresse IP: " #Afficher message
	read ipVar #Lecture donnée saisie utilisateur
	GET $ipVar #commande
	echo -e " \n" #Saute une ligne
	read -rsn1 -p"*** Appuyez sur une touche pour retourner au menu ***" variable;echo #retour au menu
}

function choixReseauQuatre #Serveur de noms
{
	clear #Effacer l'écran
	echo "Entrez un nom de domaine: " #Afficher message
	read domainVar #Lecture donnée saisie utilisateur
	dig NS $domainVar  #commande de recherche name server
	echo -e " \n" #Saute une ligne
	read -rsn1 -p"*** Appuyez sur une touche pour retourner au menu ***" variable;echo #retour au menu
}

function choixReseauCinq #Serveur courriel
{
	clear #Effacer l'écran
	echo "Entrez un nom de domaine: " #Afficher message
	read domainVar #Lecture donnée saisie utilisateur
	host -t MX $domainVar  #commande : chercher nom machine avec un serveur de domaine, -t (type MX)
	echo -e " \n" #Saute une ligne
	read -rsn1 -p"*** Appuyez sur une touche pour retourner au menu ***" variable;echo #retour au menu
}
#***************************************
#***************************************


#***************************************
#***************************************
# Fonction pour Sous-menu disque
function choixDisque
{
while :
do
	clear
	echo -e "Sous-menu disque\n"
	echo -e "\t Option   description \n"
	echo -e "\t 1) \t Utilisation: "
	echo -e "\t 2) \t Fichiers: "
	echo -e "\t 3) \t Revenir au menu principal: "
	echo -e "\tVotre choix : \c"
	read choix
	
	case $choix in
	1) choixDisqueUn;;
	2) choixDisqueDeux;;
	3) return;;
	esac
done
}

function choixDisqueUn #Utilisation
{
	clear #Effacer l'écran
	du /etc | more; # Stat sur utilisation disque (du), repertoire /etc, afficher page scrolling (more) avec un pipe
	}

function choixDisqueDeux #Fichiers
{
	clear #Effacer l'écran
	df -h -k; #Info sur syst fichier en 6 col. bloc 1024bytes (-k),lisible humain(-h)
	echo -e " \n" #Saute une ligne
	read -rsn1 -p"*** Appuyez sur une touche pour retourner au menu ***" variable;echo #retour au menu
}
#***************************************
#***************************************


#***************************************
#***************************************
# Fonction pour Sous-menu X
function choixReseauUtil
{
while :
do
	clear
	echo -e "Sous-menu réseau commandes utilitaires\n"
	echo -e "\t Option   description \n"
	echo -e "\t 1) \t Tester disponibilité d'une station (PING): "
	echo -e "\t 2) \t Résolution DNS, adresse IP pour un nom donné: "
	echo -e "\t 3) \t Résolution DNS inverse, nom pour une adresse IP donnée: "
	echo -e "\t 4) \t Filtrer selon un protocole les connexions actives (SERVEUR): "
	echo -e "\t 5) \t Revenir au menu principal: "
	echo -e "\tVotre choix : \c"
	read choix
	
	case $choix in
	1) choixReseauUtilUn;;
	2) choixReseauUtilDeux;;
	3) choixReseauUtilTrois;;
	4) choixReseauUtilQuatre;;
	5) return;;
	esac
done
}

function choixReseauUtilUn #Tester disponibilité d'une station (PING)
{
	clear #Effacer l'écran
	echo "Entrez un adresse IP: " #Afficher message
	read ipVar #Lecture donnée saisie utilisateur
    ping -c 1 $ipVar > /dev/null  #commande, (-c 1) un seul ping
		if [ $? -eq 0 ] 
		then echo "La station à l'adresse IP: $ipVar à répondu."
		else echo "La station à l'adresse IP: $ipVar ne répond pas."
		fi
	echo -e " \n" #Saute une ligne
	read -rsn1 -p"*** Appuyez sur une touche pour retourner au menu ***" variable;echo #retour au menu
}

function choixReseauUtilDeux #Obtenir une adresse IP à partir d'un nom de domaine
{
	clear #Effacer l'écran
	echo "Entrez un nom de domaine: " #Afficher message
	read domainVar #Lecture donnée saisie utilisateur
	dig $domainVar A +short #commande, Adresse IPV4
	dig $domainVar AAAA +short #commande, Adresse IPV6
	echo -e " \n" #Saute une ligne
	read -rsn1 -p"*** Appuyez sur une touche pour retourner au menu ***" variable;echo #retour au menu
}

function choixReseauUtilTrois #Obtenir un nom de domaine pointé par une adresse IP
{
	clear #Effacer l'écran
	echo "Entrez une adresse IP: " #Afficher message
	read ipVar #Lecture donnée saisie utilisateur
	dig -x $ipVar  #commande
	echo -e " \n" #Saute une ligne
	read -rsn1 -p"*** Appuyez sur une touche pour retourner au menu ***" variable;echo #retour au menu
}

function choixReseauUtilQuatre #Obtenir un nom de domaine pointé par une adresse IP
{
	clear #Effacer l'écran
	echo "Entrez un protocole pour le filtre: " #Afficher message
	read ipVar #Lecture donnée saisie utilisateur
	netstat -tl | grep $ipVar  #commande
	echo -e " \n" #Saute une ligne
	read -rsn1 -p"*** Appuyez sur une touche pour retourner au menu ***" variable;echo #retour au menu
}
#***************************************
#***************************************



#***************************************
#***************************************
# Fonction pour quitter le programme
function sortie
{
	clear #Effacer l'écran
	echo "Merci d'avoir utilisé monapp" #Afficher message
	sleep 2 #délais de 2 secondes
	exit #Retour au prompt
}
#***************************************
#***************************************



#Boucle principale
while :
do
	clear
	echo -e "Menu principal \n"
	echo -e "\t Option   description \n"
	echo -e "\t 1) \t Système"
	echo -e "\t 2) \t Réseau"
	echo -e "\t 3) \t Disque"
	echo -e "\t 4) \t Réseau commandes utilitaires"
	echo -e "\t 5) \t Quitter \n"
	echo -e "\tVotre choix : \c"
	read choix
	
	case $choix in
	1) choixSysteme;;
	2) choixReseau;;
	3) choixDisque;;
	4) choixReseauUtil;;
	5) sortie;;
	esac
done
