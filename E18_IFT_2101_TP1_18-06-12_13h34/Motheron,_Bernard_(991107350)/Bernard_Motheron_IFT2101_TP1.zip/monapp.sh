#! /bin/bash

# TP1 Bernard Motheron 991107350 IFT-2101 NRC:54907 été2018

#________________________________________________________________________________
#_____________________________  SOUS-MENU SYSTEME _______________________________
#________________________________________________________________________________

#***************************************************************
#  	Fonction : executerTopCommand
#  	Objectif : Afficher les processus en execution et le 
#                  detail des threads
#  	Notes    : Choix 1 du sous-menu systeme
#***************************************************************
function executerTopCommand
{
  echo "Liste des processus en execution et le detail des threads"
  echo "---------------------------------------------------------"

  top -H
  # -H : affichage par threads
	

  echo "Appuyez sur 'Enter' pour continuer..."	
  read unusedVar
}

#***************************************************************
#  	Fonction : executerCrondCommand
#  	Objectif : Lister les fichiers ouverts par crond
#  	Notes    : Choix 2 du sous-menu systeme
#***************************************************************
function executerCrondCommand
{
  echo "Liste des fichiers ouverts par crond"
  echo "------------------------------------"

   lsof | grep crond

  echo "Appuyez sur 'Enter' pour continuer..."	
  read unusedVar
}

#***************************************************************
#  Fonction : afficherSousMenuSysteme
#  Objectif : Afficher les choix de commande systeme
#  Notes    : Choix 1 du menu principal
#***************************************************************
function afficherSousMenuSysteme
{
  clear
  echo "Faire un choix parmis les commandes suivantes:"
  echo "1- Afficher les processus en execution et details des threads."
  echo "2- Lister   les fichiers ouverts par le service crond."
  echo "3- revenir au menu principal"
  read iChoixSmSysteme
  clear
  case $iChoixSmSysteme in
	1) executerTopCommand      ;;
	2) executerCrondCommand    ;;
	3)                         ;;
	*) afficherSousMenuSysteme ;;
  esac
}
#________________________________________________________________________________
#____________________________  SOUS-MENU RESEAU _________________________________
#________________________________________________________________________________

#***************************************************************
# 	Fonction : executerSocketEnEcoute
#  	Objectif : Lister les sockets ouverts en écoute
#  	Notes    : Choix 1 du menu Reseau
#***************************************************************
function executerSocketEnEcoute
{
  echo "Afficher les ports en ECOUTE sur ce serveur"
  echo "-------------------------------------------"

  sudo netstat -ntlp | grep LISTEN

  echo "Appuyez sur 'Enter' pour continuer..."	
  read unusedVar
}


#***************************************************************
#  	Fonction : executerSocketOuverts
#  	Objectif : Trouver les ports ouvert pour une adresse IP
#  	Notes    : Choix 2 du menu Reseau
#       Input    : Une adresse IP
#***************************************************************
function executerSocketOuverts
{
  echo "Afficher les ports ouvert selon une adresse IP"
  echo "----------------------------------------------"

  echo "entrez l'adresse IP pour laquelle vous voulez trouver les port ouverts"
  read iIpToScan	
  nmap $iIpToScan

  echo "Appuyez sur 'Enter' pour continuer..."	
  read unusedVar
}

#***************************************************************
# 	Fonction : executerPageDistante
#  	Objectif : Affiche le contenu HTML d'une page web pour
#		   une adresse IP
#  	Notes    : Choix 3 du menu Reseau
#	Input    : Une adresse IP
#***************************************************************
function executerPageDistante
{
  echo "Affiche le contenu HTML d'une page web selon une adresse IP"
  echo "-----------------------------------------------------------"

  echo "Entrez l'adresse IP"
  read iAdresseIP

  GET /index.html HTTP/1.1\r\nHost: $1

  echo "Appuyez sur 'Enter' pour continuer..."	
  read unusedVar
}

#***************************************************************
#  	Fonction : executerServeurDeNoms
#  	Objectif : Affiche le serveur DNS autoritaire pour
#		   un nom de domaine
#  	Notes    : Choix 4 du meunu Reseau
#	Input    : Un nom de domaine 
#***************************************************************
function executerServeurDeNoms
{
  echo "Trouver le serveur DNS autoritaire pour un nom de domaine"
  echo "---------------------------------------------------------"

  echo "Entrer un nom de domaine"
  read iNomDeDomaine
  host -t ns $iNomDeDomaine
  # -t ns : requete pour name server 

  echo "Appuyez sur 'Enter' pour continuer..."	
  read unusedVar
}

#***************************************************************
#  	Fonction : executerServeurCourriel
#  	Objectif : Affiche le serveur courriel pour un nom 
#		   de domaine
#  	Notes    : Choix 5 du menu Reseau
#***************************************************************
function executerServeurCourriel
{
  echo "Trouver le serveur courriel pour un nom de domaine"
  echo "--------------------------------------------------"

  echo "Entrer un nom de domaine"
  read iNomDeDomaine
  host -t mx $iNomDeDomaine
  # -t ns : requete pour serveur courriel

  echo "Appuyez sur 'Enter' pour continuer..."	
  read unusedVar
}

#***************************************************************
#  Fonction : afficherSousMenuReseau
#  Objectif : Afficher les choix de commande reseau
#  Notes    : Choix 1 du menu principal
#***************************************************************
function afficherSousMenuReseau
{
  clear
  echo "Faire un choix parmis les commandes suivantes:"
  echo "1- Afficher les socket en écoute localement."
  echo "2- Afficher les socket ouverts (distant)."
  echo "3- Afficher le contenu HTML d'une page distante."
  echo "4- Trouver  le serveur DNS autoritaire pour un nom de domaine."
  echo "5- Trouver  le serveur courriel pour un nom de domaine"
  echo "6- revenir au menu principal"
  read iChoixSmReseau
  clear
  case $iChoixSmReseau in
	1) executerSocketEnEcoute  ;;
	2) executerSocketOuverts   ;;
	3) executerPageDistante    ;;
	4) executerServeurDeNoms   ;;
	5) executerServeurCourriel ;;
	6) 			   ;;
	*) afficherSousMenuReseau  ;;
  esac
}


#________________________________________________________________________________
#____________________________  SOUS-MENU DISQUE _________________________________
#________________________________________________________________________________

#***************************************************************
#  	Fonction : executerUtilisationDisque
#  	Objectif : Affiche les statisques d'utilisation du disque
#                  de tous les fichiers du dossier /etc
#  	Notes    : Choix 1 du menu Disque
#***************************************************************
function executerUtilisationDisque
{
  echo "statisques d'utilisation du disque de tous les fichiers du dossier /etc"
  echo "-----------------------------------------------------------------------"
  du -a --time -c /etc | more
  # -a: disk usage de toutes les fichiers et repertoires
  # --time  : en ordre d'heure de modification
  # -c: affiche le grand total de l'utilisation du disque a la derniere ligne

  echo "Appuyez sur 'Enter' pour continuer..."	
  read unusedVar
}

#***************************************************************
#  	Fonction : executerListFichiersSys
#  	Objectif : Affiche les informations du systeme de
#                  fichiers en 6 colonnes et bloc de 1024 oct
#  	Notes    : Choix 2 du menu Disque
#***************************************************************
function executerListFichiersSys
{
  echo "Informations sur le systeme de fichier"
  echo "--------------------------------------"
  df -k -h
  # -k : affiche en block de 1024k
  # -h : affiche toutes les statistiques d'utilisation des fichiers

  echo "Appuyez sur 'Enter' pour continuer..."	
  read unusedVar
}

#***************************************************************
#  Fonction : afficherSousMenuDisque
#  Objectif : Afficher les choix de commande disque 
#  Notes    : Choix 3 du menu principal
#***************************************************************
function afficherSousMenuDisque
{
  clear
  echo "Faire un choix parmis les commandes suivantes:"
  echo "1- Afficher les statisques d'utilisation des fichiers sous /etc."
  echo "2- Afficher les informations du systeme de fichiers."
  echo "3- revenir au menu principal"
  read iChoixSmDisque
  clear
  case $iChoixSmDisque in
	1) executerUtilisationDisque ;;
	2) executerListFichiersSys   ;;
	3)                           ;;
	*) afficherSousMenuDisque    ;;
  esac
}

#________________________________________________________________________________
#____________________________  SOUS-MENU A DEFINIR ______________________________
#________________________________________________________________________________

#***************************************************************
#  Fonction : afficherDiagnostic
#  Objectif : Lister tous les routeurs menant a une adresse IP
#  Notes    : 
#***************************************************************
function afficherDiagnostic
{
  echo "Lister tous les routeurs menant a une adresse IP"
  echo "-----------------------------------------------------------"

  echo "Entrez l'adresse IP"
  read iAdresseIP

  traceroute $iAdresseIP
  echo "Appuyez sur 'Enter' pour continuer..."	
  read unusedVar
}

#________________________________________________________________________________
#____________________________  SOUS-MENU QUITTER ________________________________
#________________________________________________________________________________

#***************************************************************
#  Fonction : quitterApp
#  Objectif : Termine le script
#  Notes    : Choix 5 du menu principal
#***************************************************************
function quitterApp
{
clear
echo "                 *     *"
echo "                 *     *"
echo "                 *     *"
echo "                 *     *"
echo "                 *     *"
echo "                 *     *"
echo ""  
echo "                       *  "
echo "       *  *  *  *  *"
echo "       *  *  *  *  *"
echo "       *  *  *  *  *"
echo "       *  *  *  *  *"
echo "       *  *  *  *  *"
echo "       *  *  *  *  *"
echo "       *  *  *  *  *"
usleep 500000
clear
echo "                   *     * *"
echo "                   *     * *"
echo "                   *     * *"
echo "                   *     * *"
echo "                  * *     *"
echo "                 *   *    *"
echo ""  
echo "                       *  "
echo "       *     *  * *   **  **"
echo "       **    *  * *  **   * *"
echo "       *     *  * *  ***  **"
echo "       *     *   *   ***  **"
echo "       **    *  *    ***  * *"
echo "       * *   *  *    ***  *  *"
echo "       *  *  *  *     **  *   *"
usleep 500000
clear
echo "                       *       *    *"
echo "                       *       *    *"
echo "                       **      *    *"
echo "                      ****     *    *"
echo "                     *    *     *  *"
echo "                    *      *     *"
echo ""  
echo "                                  *  "
echo "       ****     ***  *    *   **  *  ****"
echo "       *   *         *    *  *  *    *   *"
echo "       *  *     *    *    *  *  **   *  *"
echo "       ****     ***   *  *   *  **   ****"
echo "       *   *    *      **    *  **   *   *"
echo "       *    *   *      *     *  **   *    *"
echo "       *     *  ***   *       ** *   *     *"
usleep 500000

clear
echo "                            *        *       *"
echo "                           * *       *       *"
echo "                          *   *      *       *"
echo "                         *******     *       *"
echo "                        *       *     *     *"
echo "                       *         *      ***"
echo ""  
echo "                                               ***  "
echo "       *******     ******  *       *   *****   ***  *******"
echo "       *      *    *       *       *  *     *       *      *"
echo "       *     *     *       *       *  *     *   *   *     *"
echo "       *******     ******   *     *   *     *   *   *******"
echo "       *      *    *         *   *    *     *   *   *      *"
echo "       *       *   *          * *     *     *   *   *       *"
echo "       *        *  ******      *       *****    *   *        *"
usleep 2000000
  clear
  exit
}

#________________________________________________________________________________
#______________________________ menu principal __________________________________
#________________________________________________________________________________

#***************************************************************
#  Fonction : afficherMenuPrincipal
#  Objectif : afficher les choix du menu principal
#  Notes    :
#***************************************************************
while :
do
  clear
  echo "Veuillez faire un choix dans le menu suivant:"
  echo "1- Système"
  echo "2- Réseau"
  echo "3- Disque"
  echo "4- Diagnostique"
  echo "5- Quitter"

  read iChoixPrincipal
  clear

  case $iChoixPrincipal in
	1) afficherSousMenuSysteme  ;;
	2) afficherSousMenuReseau   ;;
	3) afficherSousMenuDisque   ;;
	4) afficherDiagnostic       ;;
	5) quitterApp               ;;   
  esac
done





