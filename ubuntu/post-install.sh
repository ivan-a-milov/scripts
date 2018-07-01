#!/bin/bash

PACKAGES_TO_INSTALL="  "
PACKAGES_TO_INSTALL="$PACKAGES_TO_INSTALL gnome-session-flashback gnome-session"
PACKAGES_TO_INSTALL="$PACKAGES_TO_INSTALL screen htop emacs "
PACKAGES_TO_INSTALL="$PACKAGES_TO_INSTALL git tig jq aptitude "
PACKAGES_TO_INSTALL="$PACKAGES_TO_INSTALL firefox  "

sudo apt-get --yes install $PACKAGES_TO_INSTALL

sudo update-alternatives --set gdm3.css /usr/share/gnome-shell/theme/gnome-shell.css

git clone 'https://github.com/ivan-a-milov/configs'
cd configs
./install.sh $HOME

gnome-session-quit --force

