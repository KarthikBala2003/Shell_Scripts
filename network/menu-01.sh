#!/bin/bash
#sudo yum install dialog

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="Backtitle here"
TITLE="Title here"
MENU="Choose one of the following options:"

OPTIONS=(1 "Google"
         2 "Heroku 1"
         3 "Heroku 2")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

# clear
case $CHOICE in
        1)
            echo "You chose Google"
            ;;
        2)
            echo "You chose Heroku 1"
            ;;
        3)
            echo "You chose Heroku 2"
            ;;
esac