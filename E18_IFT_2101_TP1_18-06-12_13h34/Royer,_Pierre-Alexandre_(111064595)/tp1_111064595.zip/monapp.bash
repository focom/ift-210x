#!/bin/bash
#************************************************************* 
#   Fichier         : monapp.bash
#   Projet          : TP1 ift-2101
#   Auteur(s)       : Pierre-Alexandre Royer
#   Cours           : Protocoles et technologies Internet
#   École           : Universite Laval
#   Session         : ETE 2018
#************************************************************* 

#************************************************************* 
#   Section des fonctions utilitaires
#*************************************************************

function Quitter 
{
  clear
  echo "Au revoir!"
  sleep 2
  exit
}

function socketOuverts 
{
  echo -e "Adresse ip?: \c"
  read adresse
  portMin=1
  portMax=65535
  for ((port=$portMin; port<=$portMax; port++))
  do
    (echo > /dev/tcp/$adresse/$port) >/dev/null 2>&1 && echo "$port ouvert"
  done 
}

function pageDistante
{
  echo -e "Adresse ip?: \c"
  read adresse
  exec 3<>/dev/tcp/$adresse/80
  echo -e "GET HTTP/1.1\r\nhost: $adresse\r\nConnection: close\r\n\r\n" >&3
  cat <&3
}

function serveurNoms
{
  echo -e "Nom de domaine?: \c"
  read nomDomaine
  nslookup -type=soa $nomDomaine
}

function serveurCourriel
{
   echo -e "Nom de domaine?: \c"
  read nomDomaine
  nslookup -type=mx $nomDomaine
}

#************************************************************* 
#   Section des fonctions de menu et sous-menu
#*************************************************************

function menuPrincipal
{
  while :
  do

    clear
    echo -e "Menu Systeme: \n"
    echo -e "Option 1: Sous-menu Syteme \n"
    echo -e "Option 2: Sous-menu Reseau \n"
    echo -e "Option 3: Sous-menu Disque \n"
    echo -e "Option 4: Sous-menu Statistiques \n"
    echo -e "Option 5: Quitter \n"
    echo -e "Votre choix: \c"
    read choix

    case $choix in 
      1) menuSysteme;;
      2) menuReseau;;
      3) menuDisque;;
      4) menuStatistiques;;
      5) Quitter;;
      *) echo -e "Choix non valide."; sleep 0.5;;
    esac
    
  done
}

function menuSysteme 
{
  while :
  do

    clear
    echo -e "Sous-menu Systeme: \n"
    echo -e "Option 1: top \n"
    echo -e "Option 2: crond \n"
    echo -e "Option 3: Revenir au menu principal \n"
    echo -e "Votre choix: \c"
    read choix

    filesCrond=$(pgrep -f crond)

    case $choix in 
      1) clear; top -H -b -n 1; sleep 5; menuSysteme;;
      2) clear; lsof -p $filesCrond ; sleep 5; menuSysteme;;
      3) menuPrincipal;;
      *) echo -e "Choix non valide."; sleep 0.5;;
    esac
   
  done
}

function menuReseau
{
  while :
  do

    clear
    echo -e "Sous-menu Reseau: \n"
    echo -e "Option 1: Socket en ecoute \n"
    echo -e "Option 2: Socket ouverts \n"
    echo -e "Option 3: Page distante \n"
    echo -e "Option 4: Serveur de noms \n"
    echo -e "Option 5: Serveur courriel \n"
    echo -e "Option 6: Revenir au menu principal \n"
    echo -e "Votre choix: \c"
    read choix

    case $choix in 
      1) clear; netstat -l; sleep 5; menuReseau;;
      2) clear; socketOuverts; sleep 5; menuReseau;;
      3) clear; pageDistante;sleep 5; menuReseau;;
      4) clear; serveurNoms;sleep 5; menuReseau;;
      5) clear; serveurCourriel;sleep 5; menuReseau;;
      6) menuPrincipal;;
      *) echo -e "Choix non valide."; sleep 0.5;;
    esac
   
  done
}

function menuDisque
{
  while :
  do

    clear
    echo -e "Sous-menu Disque: \n"
    echo -e "Option 1: Utilisation \n"
    echo -e "Option 2: Fichiers \n"
    echo -e "Option 3: Revenir au menu principal \n"
    echo -e "Votre choix: \c"
    read choix

    case $choix in 
      1) clear;du -ak /etc | more; menuDisque;;
      2) clear;df -hk ; sleep 5; menuDisque;;
      3) menuPrincipal;;
      *) echo -e "Choix non valide."; sleep 0.5;;
    esac
   
  done
}

function menuStatistiques
{
  while :
  do

    clear
    echo -e "Sous-menu Statistiques de performance: \n"
    echo -e "Option 1: Statistiques de la memoire virtuelle\n"
    echo -e "Option 2: Statistiques des I/Os \n"
    echo -e "Option 3: Statistiques du processeur \n"
    echo -e "Option 4: Revenir au menu principal \n"
    echo -e "Votre choix: \c"
    read choix

    case $choix in 
      1) clear;vmstat; sleep 5;menuStatistiques;;
      2) clear;iostat; sleep 5;menuStatistiques;;
      3) clear;mpstat; sleep 5;menuStatistiques;;
      4) menuPrincipal;;
      *) echo -e "Choix non valide."; sleep 0.5;;
    esac
   
  done
}

#************************************************************* 
#   Section d'execution
#*************************************************************

menuPrincipal