#! /bin/bash 

#******************************************************************
#  Fichier	: Monapp
#  Projet	: TP1
#  Auteur	: Laurent Senécal-Léonard
#  Groupe	:
#  Cours	: Protocoles et technologies Internet
#  École	: Université Laval
#  Session	: Été 2018
#  Notes	:            
#******************************************************************


#******************************************************************
#  Fonction	: gererRetourMenu
#  Objectif	: Permet de gérer/affichier le retour au menu principal
#                 et ensuite de lire l'entré de l'utilisateur.
#  Notes	: La valeur entré est envoyé à la fonction redirectionMenu
#******************************************************************
gererRetourMenu()
{	
	clear
	afficherMenuPrincipal
	read reponse
	redirectionMenu $reponse 
}


#******************************************************************
#  Fonction	: afficherMenuPrincipal
#  Objectif	: Affiche les éléments du menu principal
#  Notes	:
#******************************************************************
afficherMenuPrincipal()
{
	echo MENU PRINCIPAL
	echo -------------------
	echo Selectionner une des options suivantes :
	echo 1-Systeme
	echo 2-Reseau
	echo 3-Disque
	echo 4-Explorer les fichiers
	echo 5-Quitter
}


#******************************************************************
#  Fonction	: sousMenuSysteme
#  Objectif	: Permet d'afficher le sous-menu Système et exécute
#		  l'option entré par l'utilisateur.
#  Notes	: Si il n'y a pas d'argument reçu, le sous-menu est
#		  affiché. Si la valeur entré n'est pas entre 1 et 3,
#		  le sous-menu Système est affiché de nouveau.
#******************************************************************
sousMenuSysteme()
{
	clear
	
	if [ $# -lt 1 ]; then
		echo SOUS-MENU SYSTEME 
		echo -----------------
		echo Selectionner une des options suivantes :
		echo 1-Top
		echo 2-Crond
		echo 3-Revenir au menu principal
		read reponseSysteme 
	elif [ $# -eq 1 ]; then
		reponseSysteme=$1
	fi
	
	clear
	
	case $reponseSysteme in
     1)
          top -n 3 
          sousMenuSysteme
          ;;
     2)
          pidof crond | xargs lsof -p 
          echo
          read -p "Appuyez sur une touche pour revenir au menu precedant... " -n 1 -s;sousMenuSysteme
          ;;
     3)
          gererRetourMenu
          ;; 
     *)
          sousMenuSysteme
          ;;
	esac
}


#******************************************************************
#  Fonction	: sousMenuReseau
#  Objectif	: Permet d'afficher le sous-menu Réseau et exécute
#		  l'option entré par l'utilisateur.
#  Notes	: Si il n'y a pas d'argument reçu, le sous-menu est
#		  affiché. Si la valeur entré n'est pas entre 1 et 6,
#		  le sous-menu Réseau est affiché de nouveau.
#******************************************************************
sousMenuReseau()
{
	clear
	if [ $# -lt 1 ]; then
		echo SOUS-MENU RESEAU
		echo ----------------
		echo Selectionner une des options suivantes :
		echo 1-Socket en ecoute localement
		echo 2-Socket ouvert 
		echo 3-Page distante
		echo 4-Serveur de noms
		echo 5-Serveur courriel
		echo 6-Revenir au menu principal
		read reponseReseau 
		echo
	elif [ $# -eq 1 ]; then
		reponseReseau=$1
	fi
	
	clear
	
	case $reponseReseau in
     1)
          netstat -lx
          echo
          read -p "Appuyez sur une touche pour revenir au menu precedant... " -n 1 -s;sousMenuReseau  
          ;;
     2)
          echo "Entrez l'IP désiré"
          read IPCible
          echo
          echo Ports :
          echo -------
          port_debut=1
          port_fin=1500
          for ((port=$port_debut; port<=$port_fin; port++))
          do
          	(echo >/dev/tcp/$IPCible/$port) >/dev/null 2>&1 && echo $port "ouvert"
          done
          ;;
     3)
     	  echo "Entrez le nom de domaine"
     	  read nomDomaine
     	  echo
	  exec 3<>/dev/tcp/$nomDomaine/80
	  echo -e "GET / HTTP/1.1\r\nHost: $nomDomaine\r\nConnection: Close\r\n\r\n" >&3
	  cat <&3
          ;; 
     4)
          echo "Entrez un nom de domaine:"
          read nomDomaine
          echo
          dig -t ns $nomDomaine
          read -p "Appuyez sur une touche pour revenir au menu precedant... " -n 1 -s;sousMenuReseau
          ;; 
     5)
          echo "Entrez un nom de domaine:"
          read nomDomaineMail
          echo
          nslookup -type=mx $nomDomaineMail
          read -p "Appuyez sur une touche pour revenir au menu precedant... " -n 1 -s;sousMenuReseau
          ;;
     6)
          gererRetourMenu
          ;; 
     *)
          sousMenuReseau
          ;;
	esac
}


#******************************************************************
#  Fonction	: sousMenuDisque
#  Objectif	: Permet d'afficher le sous-menu Disque et exécute
#		  l'option entré par l'utilisateur.
#  Notes	: Si il n'y a pas d'argument reçu, le sous-menu est
#		  affiché. Si la valeur entré n'est pas entre 1 et 3,
#		  le sous-menu Disque est affiché de nouveau.
#******************************************************************
sousMenuDisque()
{	
	clear
	if [ $# -lt 1 ]; then
		echo SOUS-MENU DISQUE
		echo ----------------
		echo Selectionner une des options suivantes :
		echo 1-Utilisation
		echo 2-Fichiers
		echo 3-Revenir au menu principal
		read optionDisque
		echo
	elif [ $# -eq 1 ]; then
		optionDisque=$1
	fi
	
	clear
	
	case $optionDisque in
     1)
	  du /etc --block-size=1K | more
	  echo
	  read -p "Appuyez sur une touche pour revenir au menu precedant... " -n 1 -s;sousMenuDisque		
          ;;
     2)
          df -h
          echo
	  read -p "Appuyez sur une touche pour revenir au menu precedant... " -n 1 -s;sousMenuDisque	
          ;;
     3)
          gererRetourMenu
          ;; 
     *)
          sousMenuDisque
          ;;
	esac
}


#******************************************************************
#  Fonction	: sousMenuExplorerFichiers
#  Objectif	: Permet de rechercher des fichiers à partir de leur nom
#		  ou leur contenu. Affiche aussi les 10 plus gros fichiers
#		  du repertoire /var
#  Notes	: Si il n'y a pas d'argument reçu, le sous-menu est
#		  affiché. Si la valeur entré n'est pas entre 1 et 4,
#		  le sous-menu Disque est affiché de nouveau.
#******************************************************************
sousMenuExplorerFichiers()
{	
	clear
	if [ $# -lt 1 ]; then
		echo SOUS-MENU EXPLORER FICHIERS
		echo ---------------------------
		echo "Selectionner une des options suivantes :"
		echo "1-Lister le(s) fichier(s) contenant une string spécifique dans son nom de fichier"
		echo "2-Lister le(s) fichier(s) dans /etc à partir d'un string specifique situé dans leur contenu "
		echo "3-Afficher les dix les plus volumineux dans /var "
		echo "4-Revenir au menu principal"
		read optionExplorer
		echo
	elif [ $# -eq 1 ]; then
		optionExplorer=$1
	fi
	
	clear
	
	case $optionExplorer in
     1)
	  echo "Entrez le nom du fichier"
	  read nomFichier
	  echo
	  locate -b $nomFichier
	  echo
	  read -p "Appuyez sur une touche pour revenir au menu precedant... " -n 1 -s;sousMenuExplorerFichiers		
          ;;
     2)
	  echo "Entrez la chaine de caractères"
	  read chaineATrouver
	  echo
	  grep -rnl $chaineATrouver /etc
	  echo
	  read -p "Appuyez sur une touche pour revenir au menu precedant... " -n 1 -s;sousMenuExplorerFichiers	
          ;;
     3)
          du -a /var | sort -n -r | head -n 10
          echo
          read -p "Appuyez sur une touche pour revenir au menu precedant... " -n 1 -s;sousMenuExplorerFichiers	
          ;; 
     4)
          gererRetourMenu
          ;; 
     *)
          sousMenuExplorerFichiers
          ;;
	esac

}


#******************************************************************
#  Fonction	: redirectionMenu
#  Objectif	: Redirige l'option entré par l'utilisateur vers
#		  un option du menu principal
#  Notes	:
#******************************************************************
redirectionMenu()
{
	case $1 in
     1)
          sousMenuSysteme $2
          ;;
     2)
          sousMenuReseau $2
          ;;
     3)
          sousMenuDisque $2
          ;; 
     4)
          sousMenuExplorerFichiers $2
          ;; 
     5)
          clear
          echo "Passez une belle journée!"
          sleep 2
          clear
          exit
          ;; 
     *)
          echo "Valeur non-comprise entre 1 et 5"
          sleep 1
          gererRetourMenu
          ;;
	esac

}


#******************************************************************
#  Fonction	:
#  Objectif	: Conditions principales du programme qui gère l'appel du pgm
#		  à partir du terminal. Selon les arguments entrés...
#  Notes	: J'ai décidé d'implémenter une solution différente de celle
#		  de faire un while pour gérer/afficher le menu principal.
#******************************************************************
clear
if [ $# -lt 1 ]; then
	afficherMenuPrincipal
	read reponse
	echo
	redirectionMenu $reponse
	
elif [ $# -eq 1 ] || [ $# -eq 2 ]; then
	
	redirectionMenu $1 $2
else
	echo "Nombre d'arguments invalide"
fi



