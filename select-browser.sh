#!/bin/sh

APP=`which select-browser`

# Prompt user to add script to $PATH if not already there

if [ "${APP}" = "" ]; then
    echo "Select-browser is not installed or not in your \$PATH"

    read -r -p " Do you want to install select-browser [Y/n] " RESPONSE

    case "${RESPONSE}" in
         [yY][eE][sS]|[yY]|"" )
        echo "Installing..."
        SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
        echo "${SCRIPTPATH}"
        sudo cp "${SCRIPTPATH}"/select-browser.sh /usr/local/bin/select-browser
     ;;
        [nN][oO]|[nN])
         echo "ok :'("
           ;;
        *)
     echo "Invalid input..."
     exit 1
     ;;
    esac

    exit
fi

BROWSER=$(zenity --list --text '' --column='Browser' --column='Command' --title='Select your browser' --width=200 --height=250 --print-column="2" --hide->
    "Chrome - Default" "google-chrome-stable --profile-directory="Default" %U" \
    "Firefox - Default" "firefox" \
    "Chrome - Second Profile" "google-chrome-stable --profile-directory="Profile\ 1" %U" \
)

${BROWSER} "${*}"