
#**********************************************************
#	Fonction	:	MenuP
#	Objectif	:	Boucle du menu principal
#**********************************************************
function menuP {
   while :
   do
      clear
      echo "================================================"
      echo -e "MENU PRINCIPAL \n"
      echo "================================================"
      echo -e "\t 1 \t\t Systeme"
      echo -e "\t 2 \t\t Reseau"
      echo -e "\t 3 \t\t Disque"
      echo -e "\t 4 \t\t Autre"
      echo -e "\t 5 \t\t Quitter"
      echo -e "Entrez votre choix : \c "
      read choix

      case $choix in
         1) systeme ;;
         2) reseau ;;
         3) disque ;;
	 4) autre ;;
         5) quitter ;;
      esac

   done
}

#************************************************************
#	Fonction	:	Systeme
#	Objectif	:	Boucle du menu Systeme
#************************************************************

function systeme {
   while :
   do
      clear
      echo "=============================================="
      echo -e "Menu Systeme \n"
      echo "=============================================="
      echo -e "\t 1 \t\t Top"
      echo -e "\t 2 \t\t Crond"
      echo -e "\t 3 \t\t Revenir au menu principal"
      echo -e "Entrez votre choix : \c "
      read choix
      
      case $choix  in
         1) Top ;;
         2) crond ;;
         3) menuP ;;
      esac

   done 
}

#**************************************************************
#	Fonction	:	Reseau
#	Objectif	:	Boucle du menu Reseau
#**************************************************************

function reseau {
   while :
   do
      clear
      echo "=================================================="
      echo -e "Menu Reseau \n"
      echo "=================================================="
      echo -e "\t 1 \t\t Socket en  ecoute"
      echo -e "\t 2 \t\t Socket ouvert"
      echo -e "\t 3 \t\t Page distante"
      echo -e "\t 4 \t\t Serveur de noms"
      echo -e "\t 5 \t\t Serveur de courriel"
      echo -e "\t 6 \t\t Revenir au menu pricipal"
      echo -e "Entrez votre choix : \c "
      read choix

      case $choix in
         1) socketEcoute ;;
         2) socketOuvert ;;
         3) pageDistante ;;
         4) serveurNom ;;
         5) serveurCourriel ;;
         6) menuP ;;
      esac

   done
}

#****************************************************************
#	Fonction	:	Disque
#	Objectif	:	Boucle du menu disque
#****************************************************************

function disque {
   while :
   do 
      clear
      echo "===================================================="
      echo -e "Menu Disque \n"
      echo "===================================================="
      echo -e "\t 1 \t\t Utilisation"
      echo -e "\t 2 \t\t Fichiers"
      echo -e "\t 3 \t\t Revenir au menu principal"
      echo -e "Entrez votre choix : \c "
      read choix

      case $choix in
         1) utilisation ;;
         2) fichiers ;;
         3) menuP ;;
      esac

   done
}

#****************************************************************
#	Fonction	:	autre
#	Objectif	:	Boucle du menu autre
#****************************************************************

function autre {
   while :
   do 
      clear
      echo "===================================================="
      echo -e "Menu Autre\n"
      echo "===================================================="
      echo -e "\t 1 \t\t Processus lancés"
      echo -e "\t 2 \t\t Périphériques USB connectés"
      echo -e "\t 3 \t\t Redémarrer l'ordinateur"
      echo -e "\t 4 \t\t Revenir au menu principal"
      echo -e "Entrez votre choix : \c "
      read choix

      case $choix in
         1) processus ;;
         2) usb ;;
	 3) redemarrer;;
         4) menuP ;;
      esac

   done
}


#*******************************************************************
#	Fonction	:	Top
#	Objectif	:	Affiche les processus en execution
#*******************************************************************

function Top {
   clear
   top
   sleep 4
   systeme
}
#******************************************************************************************
#	Fonction	:	crond
#	Objectif	:	Affiche la liste des fichiers ouvert par le service crond
#*******************************************************************************************

function crond {
   clear
   crontab -l
   sleep 4
   systeme
}
#******************************************************************************************
#	Fonction	:	socketEcoute
#	Objectif	:	Va lister tous les ports en écoute
#*******************************************************************************************

function socketEcoute {
   clear
   netstat -l
   sleep 4
   reseau
}
#******************************************************************************************
#	Fonction	:	socketOuvert
#	Objectif	:	Demande une adresse IP et affiche les ports ouverts
#*******************************************************************************************

function socketOuvert {
   clear
   echo -e "Entrez une adresse IP..."
   read choix
   nmap -sT -p- -Pn $choix
   sleep 4
   reseau
}
#******************************************************************************************
#	Fonction	:	pageDistante
#	Objectif	:	Demande une adresse IP et affiche son contenu html
#*******************************************************************************************

function pageDistante {
   clear
   echo -e "Entrez une adresse IP..."
   read choix
   xdg-open https://$choix
   sleep 4
   reseau
}
#******************************************************************************************
#	Fonction	:	serveurNom
#	Objectif	:	Demande un nom de domaine et affiche le serveur autoriatire
#*******************************************************************************************

function serveurNom {
   clear
   echo -e "Entrez un nom de domaine..."
   read choix
   dig $choix
   sleep 4
   reseau
}
#******************************************************************************************
#	Fonction	:	serveurCourriel
#	Objectif	:	Demande un nom de domaine et affiche le serveur qui reçoit les courriels pour le domaine.
#*******************************************************************************************

function serveurCourriel {
   clear
   echo -e "Entrez un nom de domaine..."
   read choix
   nslookup -type=mx $choix
   sleep 4
   reseau
}
#******************************************************************************************
#	Fonction	:	utilisation
#	Objectif	:	Affiche les statistiques d'utilisation du disque en Ko de tous les dossiers du dossier /etc en Ko de page en page
#*******************************************************************************************

function utilisation {
   clear
   du -k /etc | less
   sleep 4
   disque
}
#******************************************************************************************
#	Fonction	:	fichiers
#	Objectif	:	Affiche les informations du système de fichiers en blocs de 1Ko
#*******************************************************************************************

function fichiers {
   clear
   df -hk
   sleep 4
   disque
}
#******************************************************************************************
#	Fonction	:	processus
#	Objectif	:	Affiche tous les processus lancés de page en page
#*******************************************************************************************

function processus {
   clear
   ps -ef | less
   sleep 4
   autre
}
#******************************************************************************************
#	Fonction	:	usb
#	Objectif	:	Liste les périphériques USB connectés
#*******************************************************************************************

function usb {
   clear
   lsusb
   sleep 4
   autre
}
#******************************************************************************************
#	Fonction	:	redemarrer
#	Objectif	:	Redémarrer l'ordinateur
#*******************************************************************************************

function redemarrer {
   clear
   shutdown -r now
}
#**********************************************************************
#	Fonction	:	quitter
#	Objectif	: 	Termine le script
#**********************************************************************

function quitter {
   clear
   echo "Merci et à la prochaine !!!!!!!!!!!!! "
   sleep 2
   clear
   exit
}

menuP
