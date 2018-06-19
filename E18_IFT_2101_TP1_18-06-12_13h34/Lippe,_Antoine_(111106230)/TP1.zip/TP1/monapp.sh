#!/bin/bash

#Fonction pour le sous-menu système
function SousMenu_système 
{
 option=0
 #Tant que l'option 3 retour au menu principal n'est pas selectionnée, on boucle
 until [ "$option" = "3" ]; do
 #On clear et on affiche les trois options
 clear
 echo "  1) Top"
 echo "  2) Crond"
 echo "  3) Retour au menu principal"
 #On demande un input à l'utilisateur
 echo -n "Entrez votre choix: "
 read option
 echo ""
 #On effectue les cas selon ce que l'utilisateur a entré
 case $option in
 1 ) top -H; press_enter ;;
 2 ) crond; press_enter ;;
 3 ) main_menu; press_enter ;;
 * ) tput setf 3;echo "Entrez 1, 2 ou 3";tput setf 3; 
 esac

 done
}
#Fonction pour les socket ouverts dans le sous-menu réseau
function Socket_ouverts {
 #On demande l'adresse IP désiré
 echo "Adresse IP: ";
 read adresse_ip;
 #On scanne tous les ports ouverts
 nmap -p 1-65535 $adresse_ip;
 echo ""
 read -p "Appuyez sur une touche pour continuer... " -n1 -s;
}
#Fonction pour page distante dans le sous-menu réseau
function Page_distante {
 #On demande l'adresse IP désiré
 echo "Adresse IP: ";
 read adresse_ip;
 #On va chercher le code source de la page
 wget -qO- $adresse_ip | cat ;
 echo ""
 read -p "Appuyez sur une touche pour continuer... " -n1 -s;
}
#Fonction pour les serveurs de nom
function Serveur_noms {
 #On demande le nom de domaine désiré
 echo "Nom de domaine: ";
 read nom_domaine;
 #On va chercher les informations sur le nom de domaine
 dig $nom_domaine soa;
 read -p "Appuyez sur une touche pour continuer... " -n1 -s;
}
#Fonction pour les serveurs de courriels
function Serveur_courriels {
 #On demande le nom de domaine désiré
 echo "Nom de domaine: ";
 read nom_domaine;
 #On va chercher les informations désirées sur le nom de domaine
 dig $nom_domaine MX;
 read -p "Appuyez sur une touche pour continuer... " -n1 -s;
}
#Fonction pour le sous-menu réseau
function SousMenu_réseau
{
 option=0
 #Tant que l'option 6 retour au menu principal n'est pas selectionnée, on boucle
 until [ "$option" = "6" ]; do
 #On affiche les options du sous-menu
 clear
 echo "  1) Socket en écoute"
 echo "  2) Socket ouverts"
 echo "  3) Page distante"
 echo "  4) Serveur de noms"
 echo "  5) Serveur courriel" 
 echo "  6) Retour au menu principal"
 #On demande le choix à l'utilisateur
 echo -n "Entrez votre choix: "
 read option
 echo ""
 #On effectue les opérations nécessaires selon le choix de l'utilisateur
 case $option in
 1 ) netstat -l |more ; press_enter ;;
 2 ) Socket_ouverts; press_enter ;;
 3 ) Page_distante; press_enter ;;
 4 ) Serveur_noms; press_enter ;;
 5 ) Serveur_courriels; press_enter ;;
 6 ) main_menu; press_enter ;;
 * ) tput setf 6;echo "Entrez 1, 2, 3, 4, 5 ou 6";tput setf 6; 
 esac

 done
}
#Fonction sous-menu disque
function SousMenu_disque
{
 option=0
 #Tant que l'option 3 retour au menu principal n'est pas selectionnée, on boucle
 until [ "$option" = "3" ]; do
 clear
 echo "  1) Utilisation"
 echo "  2) Fichiers"
 echo "  3) Retour au menu principal"
 #On demande le choix à l'utilisateur
 echo -n "Entrez votre choix: "
 read option
 echo ""
 #On effectue les opérations nécessaires selon le choix de l'utilisateur
 case $option in
 1 ) du -ahk /etc |more; press_enter ;;
 2 ) df -B 1024; press_enter ;;
 3 ) main_menu; press_enter ;;
 * ) tput setf 3;echo "Entrez 1, 2 ou 3";tput setf 3; 
 esac

 done
}
#Fonction menu principal
function main_menu 
{
option=0
#Tant que l'option 5 Quit n'est pas selectionnée, on boucle
until [ "$option" = "5" ]; do
clear
echo "  1) Système"
echo "  2) Réseau"
echo "  3) Disque"
echo "  4) à définir"
echo "  5) Quit"
#On demande le choix à l'utilisateur
echo -n "Entrez votre choix: "
read option
echo ""
#On effectue les opérations nécessaire selon le choix de l'utilisateur
case $option in
    1 ) SousMenu_système ; press_enter ;;
    2 ) SousMenu_réseau ; press_enter ;;
    3 ) SousMenu_disque ; press_enter ;;
    4 ) exit;;
    5 ) echo "Bye...";sleep 2;clear;exit;;
    * ) tput setf 5;echo "Entrez 1, 2, 3, 4 ou 5";tput setf 5; 
esac
done
 }
#Début du programme
main_menu
