#!/usr/bin/env bash

# Pour chaque item du menu principale une variable avec le nom de l'option précédé par menu_ doit exister.
menu=("Système" "Réseau" "Disque" "Math" "Quitter")

# Pour chaque sous menu une fonction avec le nom de l'option (sans majuscule avec les caractères autre que a-z remplacer par _) doit exister.
menu_systeme=("Top processus" "Crond" "Revenir au menu principale")
menu_reseau=("Socket en écoute (LISTENING) localement" "Socket ouverts (distant)" "Page distante" "Serveur de noms" "Serveur courriel" "Revenir au menu principale")
menu_disque=("Utilisation" "Fichiers" "Revenir au menu principale")
menu_math=("Fibonacci" "Nombre premier" "Revenir au menu principale")

PS3="Veuillez selectionner une option: "

affichage_menu() {
    clear
    print_principale # Affichage titre menu principale

    # Affiche les options du menu principale
    select option in "${menu[@]}"
    do
        if [[ $(($REPLY)) -gt 0 && $REPLY -le ${#menu[*]} ]] # Verifie que l'option est valide
        then
            affichage_sousmenu $option
        else
            affichage_menu
        fi
    done
}

affichage_sousmenu() {
    option=$(echo ${1,,}  | sed 's/[éè]/e/g')

    clear
    print_${option} # Affichage du titre du sous menu

    # Allez chercher les options de sous menu et les afficher
    nom_menu=menu_$option[@]

    select option_sousmenu in "${!nom_menu}"
    do
        if [[ $(($REPLY)) -gt 0 && $(($REPLY)) ]] # Verifie que l'option est valide
        then
            clear
            exec_option "$option_sousmenu" # Faire l'option choisie
        fi
        clear
        affichage_sousmenu "$1" # Revenir au sous menu
    done
}

# Execute la fonction du sous-menu
exec_option() {
    option=$(echo ${1,,}  | sed 's/[éè \(\)]/_/g')
    $option
}

attendre() {
    echo "Appuyer sur n'importe quelle touche pour continuer"
    read
}

revenir_au_menu_principale() {
    affichage_menu
}

print_principale() {
    echo "  __  __                    _____      _            _             _      "
    echo " |  \/  |                  |  __ \    (_)          (_)           | |     "
    echo " | \  / | ___ _ __  _   _  | |__) | __ _ _ __   ___ _ _ __   __ _| | ___ "
    echo " | |\/| |/ _ \ '_ \| | | | |  ___/ '__| | '_ \ / __| | '_ \ / _\` | |/ _ \ "
    echo " | |  | |  __/ | | | |_| | | |   | |  | | | | | (__| | |_) | (_| | |  __/"
    echo " |_|  |_|\___|_| |_|\__,_| |_|   |_|  |_|_| |_|\___|_| .__/ \__,_|_|\___|"
    echo "                                                     | |                 "
    echo "                                                     |_|                 "
}

print_systeme() {
    echo "   _____           _   __                 ";
    echo "  / ____|         | |  \_\                ";
    echo " | (___  _   _ ___| |_ ___ _ __ ___   ___ ";
    echo "  \___ \| | | / __| __/ _ \ '_ \` _ \ / _ \ ";
    echo "  ____) | |_| \__ \ ||  __/ | | | | |  __/";
    echo " |_____/ \__, |___/\__\___|_| |_| |_|\___|";
    echo "          __/ |                           ";
    echo "         |___/                            ";
}

top_processus() {
    eval "top" "-H" "-n" "1"
    attendre
}

crond() {
    eval "crontab" "-l"
    attendre
}


print_reseau() {
    echo "  _____   __                       ";
    echo " |  __ \ /_/                       ";
    echo " | |__) |___  ___  ___  __ _ _   _ ";
    echo " |  _  // _ \/ __|/ _ \/ _\` | | | |";
    echo " | | \ \  __/\__ \  __/ (_| | |_| |";
    echo " |_|  \_\___||___/\___|\__,_|\__,_|";
    echo "                                   ";
    echo "                                   ";
}

socket_en__coute__listening__localement()
{
    eval "netstat" "--listening"
    attendre
}

socket_ouverts__distant_()
{
    echo "Veuillez saisir l'ip voulu"
    read ip
    eval "sudo" "nmap" "-O" $ip
    attendre
}

page_distante()
{
    echo "Veuillez saisir la page distante voulu"
    read page
    eval "curl" $page
    attendre
}

serveur_de_noms()
{
    echo "Veuillez saisir le domaine voulu"
    read domaine
    eval "dig" "-t" "ns" $domaine "+short"
    attendre
}

serveur_courriel()
{
    echo "Veuillez saisir le serveur de courriel voulu"
    read email
    eval "dig" $email "MX" "+short"
    attendre
}

print_disque() {
    echo "  _____  _                      ";
    echo " |  __ \(_)                     ";
    echo " | |  | |_ ___  __ _ _   _  ___ ";
    echo " | |  | | / __|/ _\` | | | |/ _ \ ";
    echo " | |__| | \__ \ (_| | |_| |  __/";
    echo " |_____/|_|___/\__, |\__,_|\___|";
    echo "                  | |           ";
    echo "                  |_|           ";
}

utilisation() {
    eval "find" "/etc" "-type" "f" "-exec" "du" "-h" "\{\}" "+" | "less"
    attendre
}

fichiers() {
    eval "df" "-B" "1K" "-h"
    attendre
}

print_math() {
    echo "  __  __       _   _     ";
    echo " |  \/  |     | | | |    ";
    echo " | \  / | __ _| |_| |__  ";
    echo " | |\/| |/ _\` | __| '_ \ ";
    echo " | |  | | (_| | |_| | | |";
    echo " |_|  |_|\__,_|\__|_| |_|";
    echo "                         ";
    echo "                         ";
}

fibonacci() {
    echo "Index du nombre à trouver: "
    read nb
    echo "Resultat:"
    calculerFibonacci $nb
    attendre
}

calculerFibonacci()
{
    if [ $1 -le 0 ]
    then
        echo 0
    elif [ $1 -eq 1 ]
    then
        echo 1
    else
        echo $[ `calculerFibonacci $(($1-2))` + `calculerFibonacci $(($1-1))` ]
    fi
}

nombre_premier()
{
    echo "Vérifier si le nombre suivant est premier:"
    read nb

    if [[ $((`calculerNombrePremier $nb`)) -eq 1 ]]
    then
        echo "Le nombre $nb est premier"
    else
        echo "Le nombre $nb est n'est pas premier"
    fi
    attendre
}

calculerNombrePremier()
{
    if [ $1 -eq 1 ]
    then
        echo 0
        exit
    fi

    i=2
    while [ $i -lt $1 ]
    do
        if [ $(($1 % $i)) -eq 0 ]
        then
            echo 0
            exit


        fi
        i=$(($i+1))
    done
    echo 1

}
print_quitter() {
    clear
    echo "                                      _      _ ";
    echo "     /\                              (_)    | |";
    echo "    /  \  _   _   _ __ _____   _____  _ _ __| |";
    echo "   / /\ \| | | | | '__/ _ \ \ / / _ \| | '__| |";
    echo "  / ____ \ |_| | | | |  __/\ V / (_) | | |  |_|";
    echo " /_/    \_\__,_| |_|  \___| \_/ \___/|_|_|  (_)";
    echo "                                               ";
    echo "                                               ";

    sleep 2
    exit
}

function main () {
    if [ $# -eq 1 ]
    then
        index_menu=$(($1-1))
        affichage_sousmenu "${menu[$index_menu]}"
    elif [ $# -eq 2 ]
    then
        index_menu=$(($1-1))
        index_sous_menu=$(($2-1))
        premier_menu=${menu[$index_menu]}
        premier_menu=$(echo ${premier_menu,,}  | sed 's/[éè]/e/g')

        nom_menu="menu_$premier_menu[$index_sous_menu]"

        exec_option "${!nom_menu}"
    else
        affichage_menu
    fi
}

main