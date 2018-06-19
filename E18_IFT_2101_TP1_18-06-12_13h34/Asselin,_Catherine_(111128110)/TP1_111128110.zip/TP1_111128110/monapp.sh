#************************************************************
#  Fichier	: monapp.sh
#  Projet	: Travail Pratique 1
#  Auteur	: Catherine Asselin (111 128 110)
#  Groupe	: IFT-2101
#  Cours	: Protocoles et technologies Internet
#  École	: Université Laval
#  Session	: Été 2018 
#************************************************************

#************************************************************
#  Fonction	: cmdTop
#  Objectif	: Show all running processus and thread
#		  Execute the top command in the Systeme menu
#************************************************************
function cmdTop
{
	clear
	top
	echo ""
        read -p "Press enter to continue"
	menuSysteme
	return 1
}

#************************************************************
#  Fonction     : cmdCrond
#  Objectif     : Show all open files
#		  Execute the crond command in the Systeme menu
#************************************************************
function cmdCrond
{
	clear
	echo "Please wait ..."
	echo ""
	lsof | head
	echo ""
        read -p "Press enter to continue"
	menuSysteme
	return 1
}

#************************************************************
#  Fonction     : menuSysteme      
#  Objectif     : Print the Systeme menu with all suboptions                                           
#************************************************************
function menuSysteme
{
        clear
        echo "SYSTÈME"
	echo ""
	echo "1 - top"
        echo "2 - crond"
        echo "3 - Back to Main Menu"
        echo ""
        read -p "Go to " MENU
	if [ $MENU == 1 ] 
	then 
		cmdTop
        elif [ $MENU == 2 ]
        then
                cmdCrond
	elif [ $MENU == 3 ]
        then
                mainMenu
	else
		echo ""
                echo "Invalid number entered."
               	sleep 2
		clear
		menuSysteme
        fi
}

#************************************************************
#  Fonction     : socket      
#  Objectif     : Show all open and listening socket of the machine                                           
#************************************************************
function socket
{
	clear
        netstat -l
	echo ""
        read -p "Press enter to continue"
        menuReseau
        return 1
}

#************************************************************
#  Fonction     : openSocket      
#  Objectif     : Show all open ports of the machine with
#                 the entered IP address                                           
#************************************************************
function openSocket
{
        clear
        read -p "Enter a IP address : " IP_ADDRESS
	netstat $IP_ADDRESS
	echo ""
        read -p "Press enter to continue"
        menuReseau
        return 1
}

#************************************************************
#  Fonction     : pageDistante      
#  Objectif     : Show the HTML contents of the desired server                                           
#************************************************************
function pageDistante
{
        clear
        read -p "Enter a IP address : " IP_ADDRESS
	echo "Please enter : GET /"
	nc $IP_ADDRESS 80
	echo ""
        read -p "Press enter to continue"
        menuReseau
        return 1
}

#************************************************************
#  Fonction     : serveurNoms      
#  Objectif     : Show the server's name of the desired domain                                           
#************************************************************
function serveurNoms
{
        clear
        read -p "Enter a domain name : " DOMAIN
        host -t ns $DOMAIN
	echo ""
	nslookup $DOMAIN
	echo ""
	read -p "Press enter to continue"
        menuReseau
        return 1
}

#************************************************************
#  Fonction     : serveurCourriel      
#  Objectif     : Show the mail's server of the desired domain                                           
#************************************************************
function serveurCourriel
{
        clear
        read -p "Enter a domain name : " DOMAIN
	host -t mx $DOMAIN
	echo ""
        read -p "Press enter to continue"
        menuReseau
        return 1
}

#************************************************************
#  Fonction     : menuReseau      
#  Objectif     : Print the Reseau menu with all suboptions                                           
#************************************************************
function menuReseau
{
	clear
        echo "RÉSEAU"
        echo ""
	echo "1 - Socket en écoute"
        echo "2 - Socket ouverts"
        echo "3 - Page distante"
	echo "4 - Serveur de noms"
	echo "5 - Serveur courriel"
	echo "6 - Back to Main Menu"
        echo ""
        read -p "Go to " MENU
        if [ $MENU == 1 ]
        then
                socket
        elif [ $MENU == 2 ]
        then
                openSocket
        elif [ $MENU == 3 ]
        then
                pageDistante
	elif [ $MENU == 4 ]
        then
                serveurNoms
	elif [ $MENU == 5 ]
        then
                serveurCourriel
	elif [ $MENU == 6 ]
        then
                mainMenu
        else
                echo ""
                echo "Invalid number entered."
                sleep 2
                clear
                menuReseau
        fi
}

#************************************************************
#  Fonction     : utilisation      
#  Objectif     : Show the disk usage of the /etc folder
#		  and all files within (show in Ko, with
#		  page per page view)                                           
#************************************************************
function utilisation
{
	clear
	du -a -k /etc/. | more
	echo ""
        read -p "Press enter to continue"
	menuDisque
	return 1
}

#************************************************************
#  Fonction     : fichiers      
#  Objectif     : Show the system files info in 1024 blocs                                           
#************************************************************
function fichiers
{
	clear
	df -h -k
	echo ""
	read -p "Press enter to continue"
	menuDisque
	return 1
}

#************************************************************
#  Fonction     : menuDisque      
#  Objectif     : Print the Disque menu with all suboptions                                           
#************************************************************
function menuDisque
{
	clear
        echo "DISQUE"
        echo ""
	echo "1 - Utilisation"
        echo "2 - Fichiers"
        echo "3 - Back to Main Menu"
        echo ""
        read -p "Go to " MENU
        if [ $MENU == 1 ]
        then
                utilisation
        elif [ $MENU == 2 ]
        then
                fichiers
        elif [ $MENU == 3 ]
        then
                mainMenu
        else
                echo ""
                echo "Invalid number entered."
                sleep 2
                clear
                menuDisque
        fi
}

#************************************************************
#  Fonction     : today      
#  Objectif     : Show the current date                                           
#************************************************************
function today
{
        clear
	echo "Salutations."
        date "+Aujourd'hui, nous sommes %A le%e %B %Y"
	echo ""
        read -p "Press enter to continue"
        menuOtherOptions
        return 1	
}

#************************************************************
#  Fonction     : calendrier      
#  Objectif     : Show the calendar of the current month                                           
#************************************************************
function calendrier
{
        clear
        cal
        echo ""
        read -p "Press enter to continue"
        menuOtherOptions
        return 1
}

#************************************************************
#  Fonction     : fortune      
#  Objectif     : Tells your fortune                                           
#************************************************************
function fortune
{
        clear
        echo "Long live the revolution!"
        echo "Have a nice day."
        echo ""
        read -p "Press enter to continue"
        menuOtherOptions
        return 1
}

#************************************************************
#  Fonction     : trains       
#  Objectif     : Print I like trains until someone kills the process                                           
#************************************************************
function trains
{
        clear
	echo "Enter ^C to stop :)"
	sleep 2
        yes "I like trains"
        echo ""
        read -p "Press enter to continue"
        menuOtherOptions
        return 1
}

#************************************************************
#  Fonction     : menuOtherOptions      
#  Objectif     : Print the Other Options menu with all suboptions                                           
#************************************************************
function menuOtherOptions
{
	clear
        echo "OTHER OPTIONS"
        echo ""
        echo "1 - Today"
        echo "2 - Calendar"
	echo "3 - Fortune"
	echo "4 - I like trains"
        echo "5 - Back to Main Menu"
        echo ""
        read -p "Go to " MENU
        if [ $MENU == 1 ]
        then
                today
        elif [ $MENU == 2 ]
        then
                calendrier
	elif [ $MENU == 3 ]
	then
		fortune
	elif [ $MENU == 4 ]
	then
		trains
        elif [ $MENU == 5 ]
        then
                mainMenu
        else
                echo ""
                echo "Invalid number entered."
                sleep 2
                clear
                menuOtherOptions
	fi
}

#************************************************************
#  Fonction     : menuQuitter      
#  Objectif     : Exit the monapp.sh application with a goodbye message                                           
#************************************************************
function menuQuitter
{
	clear
	echo "Thanks for using MONAPP :)"
	echo ""
	echo "Live long and prosper"
	sleep 2
	clear
	exit 1
}

#************************************************************
#  Fonction     : mainMenu      
#  Objectif     : Print the main menu with all the submenus                                           
#************************************************************
function mainMenu
{
	clear
	echo "MONAPP BASH"
	echo ""
	echo "1 - Système"
	echo "2 - Réseau"
	echo "3 - Disque"
	echo "4 - Other Options"
	echo "5 - Quitter"
	echo ""
	read -p "Go to " MENU
	if [ $MENU == 1 ]
	then
		menuSysteme
	elif [ $MENU == 2 ]
	then
		menuReseau
	elif [ $MENU == 3 ]
	then
		menuDisque
	elif [ $MENU == 4 ]
	then
		menuOtherOptions
	elif [ $MENU == 5 ]  
	then
		menuQuitter
	else			
		echo ""
		echo "Invalid number entered."
		sleep 2
		clear
		mainMenu
	fi
}

#************************************************************      
#  Objectif     : Execute the mainMenu function to start the application
#		  The main function of the app                                           
#************************************************************
mainMenu
