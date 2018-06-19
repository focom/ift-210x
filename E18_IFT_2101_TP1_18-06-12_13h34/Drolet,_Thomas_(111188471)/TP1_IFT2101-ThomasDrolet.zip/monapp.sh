#! /bin/bash

#################################################################################
# Fichier: monapp.sh                                                            #
# Projet: TP1                                                                   #
# Auteur: Thomas Drolet                                                         #
# Matricule: 111 188 471                                                        #
# Cours: IFT-2101 - Protocoles et technologies Internet                         #
# École: Université Laval                                                       #
# Session: Été 2018                                                             #
# Notes: Permet d'exécuter plusieurs commandes affichant des résultats          #
#        utiles au niveau du système, du réseau et du disque de la machine.     #
#################################################################################

MainMenu () {              # Fonction pour le menu principal
    clear
    printf "Menu:\n"
    printf "\t1. Système\n"
    printf "\t2. Réseau\n"
    printf "\t3. Disque\n"
    printf "\t4. Réveiller une machine sur le réseau et s'y connecter\n"
    printf "\t5. Quitter\n"

    printf "Choisissez un option [1-5]: "
    read -r option

    if [ "$option" = "1" ]; then
        MenuSys
    fi
    if [ "$option" = 2 ]; then
        MenuReseau
    fi
    if [ "$option" = 3 ]; then
        MenuDisque
    fi
    if [ "$option" = 4 ]; then
        ScanSSH
    fi
    if [ "$option" = 5 ]; then

        clear 

        printf "\n< Bye! >"                     # Idéalement le but aurait été de faire "fortune | cowsay" pour quitter
        printf "\n     \   ^__^ "               # l'application, mais ce ne sont pas des commandes natives bash. Curl
        printf "\n      \  (oo)\_______ "       # non plus, alors aller chercher cette commande en ligne aurait été ardu 
        printf "\n         (__)\       )\/\ "
        printf "\n             ||----w | "
        printf "\n             ||     || \n"
    
        sleep 2
        clear
        exit
    else
        MainMenu
    fi    
}

MenuSys () {               # Fonction pour le menu Système
    clear
    option=0
    printf "Menu Système:\n"
    printf "\t1. Top\n"
    printf "\t2. Fichiers ouverts par crond\n"
    printf "\t3. Revenir au menu principal\n"

    printf "Choisissez un option [1-3]: "
    read -r option

    if [ "$option" = "1" ]; then
        top -n 1
        printf "Appuyer sur entrée pour revenir au menu Système"
        read -r option      # Trick pour attendre un key input avant de quitter
        MenuSys
    fi
    if [ "$option" = "2" ]; then
        clear
        pidCron=$(sudo ps -aux | grep /usr/sbin/cron | awk '{print $2}' | sed -n 1p)
        lsof -p $pidCron

        printf "Appuyer sur entrée pour revenir au menu Système"
        read -r option      # Trick pour attendre un key input avant de quitter
        MenuSys
    fi
    if [ "$option" = 3 ]; then
        MainMenu
    else 
        MenuSys
    fi

}

MenuReseau () {         # Fonction pour le menu réseau
    clear
    option=0
    printf "Menu Réseau:\n"
    printf "\t1. Sockets en écoute localement\n"
    printf "\t2. Sockets ouverts distant\n"
    printf "\t3. Page distante\n"
    printf "\t4. DNS authoritaire pour un nom de domaine\n"
    printf "\t5. Serveur de courriel pour un nom de domaine\n"
    printf "\t6. Revenir au menu principal\n"

    printf "Choisissez un option [1-6]: "
    read -r option

    if [ "$option" = "1" ]; then
        netstat -l

        printf "Appuyer sur entrée pour revenir au menu Reseau"
        read -r option      # Trick pour attendre un key input avant de quitter
        MenuReseau
    fi
    if [ "$option" = "2" ]; then
        clear
        host=-1
        printf "Quelle addresse: "
        read -r host      # Acquerir l'adresse du remote. (Passer dans un regex verif de IP maybe?)

        port_debut=1
        port_fin=65535

        for ((port=$port_debut; port<=$port_fin; port++))
        do
            (echo >/dev/tcp/$host/$port) >/dev/null 2>&1 && echo "$port ouvert"
        done
        
        printf "\nAppuyer sur entrée pour revenir au menu Reseau"
        read -r option      # Trick pour attendre un key input avant de quitter
        MenuReseau
    fi
    if [ "$option" = "3" ]; then
        clear
        printf "Quelle addresse: "
        read -r host      # Acquerir l'adresse du remote. (Passer dans un regex verif de IP maybe?)

        exec 3<>/dev/tcp/$host/80
        echo -e "GET / HTTP/1.1\r\nhost: $host\r\nConnection: close\r\n\r\n" >&3
        cat <&3

        printf "\nAppuyer sur entrée pour revenir au menu Reseau"
        read -r option      # Trick pour attendre un key input avant de quitter
        MenuReseau
    fi
    if [ "$option" = "4" ]; then
        clear

        printf "Quel domaine: "
        read -r host      # Acquerir l'adresse du remote. (Passer dans un regex verif de IP maybe?)

        printf "\nServeur DNS authoritaire pour $host est: "
        dig +short SOA $host | cut -d' ' -f1

        printf "\nAppuyer sur entrée pour revenir au menu Reseau"
        read -r option      # Trick pour attendre un key input avant de quitter
        MenuReseau
    fi
    if [ "$option" = "5" ]; then
        clear

        printf "Quel domaine: "
        read -r host      # Acquerir l'adresse du remote. (Passer dans un regex verif de IP maybe?)

        printf "\nServeur(s) MX pour $host: "
        dig +short MX ulaval.ca
        
        printf "Appuyer sur entrée pour revenir au menu Reseau"
        read -r option      # Trick pour attendre un key input avant de quitter
        MenuSys
    fi
    if [ "$option" = 6 ]; then
        MainMenu
    else 
        MenuReseau
    fi
}

MenuDisque () {     # Fonction pour le menu réseau
    clear
    option=0
    printf "Menu Disque:\n"
    printf "\t1. Utilisation de /etc\n"
    printf "\t2. Infos du système de fichiers\n"
    printf "\t3. Revenir au menu principal\n"

    printf "Choisissez un option [1-3]: "
    read -r option

    if [ "$option" = "1" ]; then
        
        # (for fichier in /etc/*; do
        #     stat $fichier
        # done) | less

        # cat tmp.txt | less
        # rm tmp.txt

        ( ( ls /etc -alh | awk '{printf ("%s|%s\n", $9, $5)}' | column -t -s "|" ) && printf "\n\nAppuyer sur 'q' pour quitter" ) | less

        printf "Appuyer sur entrée pour revenir au menu Disque"
        read -r option      # Trick pour attendre un key input avant de quitter
        MenuSys
    fi
    if [ "$option" = "2" ]; then

        df -Th | grep "/$"

        printf "Appuyer sur entrée pour revenir au menu Disque"
        read -r option      # Trick pour attendre un key input avant de quitter
        MenuSys
    fi
    if [ "$option" = 3 ]; then
        MainMenu
    else 
        MenuDisque
    fi

}

ScanSSH () {
    clear
    printf "Quelle est l'adresse MAC de la machine: "
    read -r mac
    broadcast=255.255.255.255
    port=4000
    echo -e $(echo $(printf 'f%.0s' {1..12}; printf "$(echo $MAC | sed 's/://g')%.0s" {1..16}) | sed -e 's/../\\x&/g') | nc -w1 -u -b $Broadcast $PortNumber
    # Magic Packet pour faire du WoL
    printf "Magic packet envoyé. Voulez-vous vous connecter à cette machine? [y/yes/N]"
    
    read -r rep

    if [ "$rep" = y ] || [ "$rep" = yes ]; then
            printf "Attendre combien de temps avant de tenter la connexion: "
            read -r timeToWait
            printf "Quelle est l'adresse IP de la machine: "
            read -r ip
            printf "Quelle est le nom d'utilisateur: "
            read -r nom
            printf "Quel port: "
            read -r port

            printf "Voulez-vous exécuter une commande au moment de la connexion? [y/yes/N]"
            read -r rep
            if [ "$rep" = y ] || [ "$rep" = yes ]; then
                printf "Quelle est la commande: "
                read -r commande

                sleep $timeToWait && ssh $nom@$ip -p $port $commande

            else
                sleep $timeToWait && ssh $nom@$ip -p $port
            fi
    fi

    printf "Appuyer sur entrée pour revenir au menu principal"
    read -r option      # Trick pour attendre un key input avant de quitter
    MainMenu


    # Le scan des 255 machines d'un reseau avec un netmask de 255.255.255.0
    # prend ENORMEMENT de temps, alors j'ai change d'idee
    
    # clear
    # addrIP=$(ifconfig | grep inet | awk '{print $2}' | head -n 1)
    # netmask=$(ifconfig | grep inet | awk '{print $4}' | head -n 1)

    # printf "Votre addresse IP: $addrIP\n"
    # printf "Votre netmask est: $netmask\n"

    # printf "Voulez-vous scanner le subnet pour trouver les machines ayant le port 22 ouvert? [y/N]\n"
    # read -r rep

    # if [ "$netmask" = "255.255.255.0" ] && [ "$rep" == 'y' ]; then
    #     echo "Machines avec port 22 ouvert"
    #     subnet=$(echo $addrIP | awk -F. '{print $1"."$2"."$3"."}')
    #     counter=0
    #     for ((addr=1; addr<=255; addr++))
    #     do
    #         ipToScan="$subnet$addr"
    #         (echo >/dev/tcp/$ipToScan/22) >/dev/null 2>&1 && (( counter++ )) && echo "$counter. $subnet$addr"
    #     done
    # fi
    


    # MainMenu
}


MainMenu 