#!/bin/bash

PACKAGES_TO_INSTALL="  "
PACKAGES_TO_INSTALL="$PACKAGES_TO_INSTALL gnome-session-flashback "
PACKAGES_TO_INSTALL="$PACKAGES_TO_INSTALL screen htop emacs "
PACKAGES_TO_INSTALL="$PACKAGES_TO_INSTALL git tig  "
PACKAGES_TO_INSTALL="$PACKAGES_TO_INSTALL pidgin firefox  "

sudo apt-get --yes install $PACKAGES_TO_INSTALL

git clone 'https://github.com/ivan-a-milov/configs'
cd configs
./install.sh $HOME

gnome-session-quit --force
