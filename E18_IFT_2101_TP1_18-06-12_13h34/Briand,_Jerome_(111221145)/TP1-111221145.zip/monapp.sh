#!/bin/bash

shopt -s expand_aliases

alias clrs='printf "\033c"'
clrs

alias mprinc='clrs && echo && echo "MENU PRINCIPAL" && echo "Choisissez une option:" && echo "1-Système" && echo "2-Réseau" && 
echo "3-Disques" && echo "4-Matériel" && echo "5-Quitter" && echo'

alias msys='clrs && echo && echo "MENU SYSTÈME" && echo "1-top" && echo "2-crond" && echo "3-Retour au menu principal"'

alias mres='clrs && echo && echo "MENU RÉSEAU" && echo "1-Socket en écoute" && echo "2-Socket ouverts" && echo "3-Page Distante" && echo "4-Serveur de noms" && echo "5-Serveur courriel" && echo "6-Retour au menu principal"'

alias mdis='clrs && echo && echo "MENU DISQUE" && echo "1-Utilisation" && echo "2-Fichiers" && echo "3-Retour au menu principal"'

alias mmat='clrs && echo && echo "MENU MATÉRIEL" && echo "1-Processeur(s)" && echo "2-PCI" && echo "3-Information Générale *Super User*" && echo "4-Retour au menu principal"'

alias mquit='echo && echo && echo && echo "Au revoir et à bientôt!" && sleep 2 && clrs'

function menuprincipal
{
    mprinc
    read -n 1 nummenu
    if [[ "$nummenu" = "1" ]]
    then
        menusysteme
    elif [[ "$nummenu" = "2" ]]
    then
        menureseau
    elif [[ "$nummenu" = "3" ]]
    then
        menudisque
    elif [[ "$nummenu" = "4" ]]
    then
        menumateriel
    elif [[ "$nummenu" = "5" ]]
    then
        mquit
    else
        menuprincipal
    fi
}

function menusysteme
{
    msys
    read -n 1 nummenu
    if [[ "$nummenu" = "1" ]]
    then
        top
    elif [[ "$nummenu" = "2" ]]
    then
        crond
    elif [[ "$nummenu" = "3" ]]
    then
        menuprincipal
    else
        menusysteme
    fi
}

function menureseau
{
    mres
    read -n 1 nummenu
    if [[ "$nummenu" = "1" ]]
    then
        clrs
        echo "Socket en écoute:"
        netstat -l
    elif [[ "$nummenu" = "2" ]]
    then
        clrs
        echo "Saisissez une addresse IP"
        read host
        clrs
        port_debut=1
        port_fin=65535
        echo $host
        for ((port=$port_debut; port<=$port_fin; port++))
        do
            (echo >/dev/tcp/$host/$port) >/dev/null 2>&1 && echo "$port ouvert"
        done
        echo "----------"        
    elif [[ "$nummenu" = "3" ]]
    then
        clrs
        echo "Saisissez une addresse IP"
        read host
        exec 3<>/dev/tcp/$host/80
        echo -e "GET / HTTP/1.1\r\nhost: $host\r\nConnection: close\r\n\r\n" >&3
        cat <&3
    elif [[ "$nummenu" = "4" ]]
    then
        clrs
        read domain
        echo "Serveur de noms"
    elif [[ "$nummenu" = "5" ]]
    then
        clrs
        read domain
        echo "Serveur courriel"
    elif [[ "$nummenu" = "6" ]]
    then
        menuprincipal
    else
        menureseau
    fi
}

function menudisque
{
    mdis
    read -n 1 nummenu
    if [[ "$nummenu" = "1" ]]
    then
        clrs
        ls -Ssh /etc | less
    elif [[ "$nummenu" = "2" ]]
    then
        clrs
        df -kh
    elif [[ "$nummenu" = "3" ]]
    then
        menuprincipal
    else
        menudisque
    fi
}

function menumateriel
{
    mmat
    read -n 1 nummenu
    if [[ "$nummenu" = "1" ]]
    then
        clrs
        lscpu
    elif [[ "$nummenu" = "2" ]]
    then
        clrs
        lspci
    elif [[ "$nummenu" = "3" ]]
    then
        clrs
        sudo lshw -short
    elif [[ "$nummenu" = "4" ]]
    then
        menuprincipal
    else
        menumateriel
    fi
}

menuprincipal

