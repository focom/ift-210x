#!/bin/bash    


menu_principal(){

    clear
    echo ${bold}MonApp v0.01.14 - Founders Edition${normal}
    echo 
    echo Veuillez choisir une entrée par son numéro de ligne.
    echo
    echo "1) Sous-menu Système"
    echo "2) Sous-menu Réseau"
    echo "3) Sous-menu Disque"
    echo "4) Sous-menu Transfer"
    echo "q) Quitter l'utilitaire"
    
    read input

    case $input in
    1) systeme;;
    2) reseau;;
    3) disque;;
    4) transfer;;
    q) exit;;
    *) echo Option invalide..;;
    esac

}

systeme(){
    clear
    echo Menu système
    echo
    echo "1) Processus en éxécution, avec threads"
    echo "2) Fichiers ouverts par crond"
    echo "r) Retour au menu principal"

    read input

    case $input in
    1)  top -H
        #systeme
        ;;
    2)  lsof -c crond
        #systeme
        ;;
    r)  menu_principal;;
    q) exit;;
    *) echo Option invalide..;;
    esac
}

reseau(){
    clear
    echo Menu réseau
    echo
    echo "1) Liste des ports ouverts de cette machine"
    echo "2) Liste des ports ouverts d'une machine distante"
    echo "3) Voir code HTML via adresse IP"
    echo "4) Adresse du/des serveur(s) DNS autoritaires"
    echo "5) Recherche du serveur de courriel via DNS"
    echo "r) Retour au menu principal"

    read input

    case $input in
    1) netstat -l | grep LISTENING;;
    2)  
        echo Donnez l\'adresse IP, MAINTENANT!
        read IP
        nmap $IP
        #reseau
        ;;
    3)  
        echo Donnez l\'adresse IP, MAINTENANT!
        read IP
        wget -qO- $IP
        #reseau
        ;;
    4)  
        echo Donnez le nom de domaine, MAINTENANT!
        read URL
        dig -t ns $URL +noall +answer
        #reseau
        ;;
    5)  
        echo Donnez le nom de domaine, MAINTENANT!
        read URL
        dig -t mx $URL +noall +answer
        #reseau
        ;;
    r) menu_principal;;
    q) exit;;
    *) echo Option invalide..;;
    esac
}

disque(){
    clear
    echo Menu disque
    echo
    echo "1) Utilisation d'espace du dossier /etc"
    echo "2) Informations sur le système de fichier"
    echo "r) Retour au menu principal"

    read input

    case $input in
    1) 
        du -k -a /etc | less
        #disque
        ;;
    2) 
        df -P -h --block-size=1024
        #disque
        ;;
    r) menu_principal;;
    q) exit;;
    *) echo Option invalide..;;
    esac
}

transfer(){
    clear
    echo Menu transfer
    echo
    echo "1) Télécharger un fichier avec scp"
    echo "2) Synchroniser un dossier avec rsync (localhost en source)"
    echo "r) Retour au menu principal"

    read input

    case $input in
    1) 
        echo "Entrez l'adresse de l'ordinateur distant"
        read remote
        echo "Entrez le fichier à copier (chemin complet)"
        read origin
        echo "Entrez le répertoire de destination"
        read destination
        echo "Entrez le nom d'utilisateur de l'ordinateur distant (c'est fini après..)"
        read username
        scp $username@$remote:$origin $destination
        #transfer
        ;;
    2) 
        echo "Entrez le répertoire d'origine (chemin complet)"
        read origin
        echo "Entrez l'adresse de l'ordinateur distant"
        read remote
        echo "Entrez le répertoire de destination"
        read destination
        echo "Entrez le nom d'utilisateur de l'ordinateur distant (c'est fini après..)"
        read username
        rsync -a $origin $username@$remote:$destination
        #transfer
        ;;
    r) menu_principal;;
    q) exit;;
    *) echo Option invalide..;;
    esac
}



menu_principal
