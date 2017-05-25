#!/bin/bash

sudo apt-get -y purge ibus im-config

dconf write /org/gnome/desktop/input-sources/mru-sources "[('xkb', 'us'), ('xkb', 'ru')]"
dconf write /org/gnome/desktop/input-sources/sources "[('xkb', 'us'), ('xkb', 'ru')]"
dconf write /org/gnome/desktop/input-sources/xkb-options "['grp:caps_toggle', 'grp_led:caps']"

