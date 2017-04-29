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

gsettings set org.gnome.desktop.wm.preferences num-workspaces 12

# works after gnome-panel was launched
# dconf write /org/gnome/gnome-panel/layout/objects/workspace-switcher/instance-config/num-rows 2

gsettings set org.gnome.desktop.wm.keybindings maximize '["<Alt><Shift>F"]'

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 '["<Control>F1"]'
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 '["<Control>F2"]'
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 '["<Control>F3"]'
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 '["<Control>F4"]'
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 '["<Control>F5"]'
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 '["<Control>F6"]'
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7 '["<Control>F7"]'
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8 '["<Control>F8"]'
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9 '["<Control>F9"]'
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-10 '["<Control>F10"]'
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-11 '["<Control>F11"]'
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-12 '["<Control>F12"]'

gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 '["<Control><Shift>F1"]'
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 '["<Control><Shift>F2"]'
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 '["<Control><Shift>F3"]'
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 '["<Control><Shift>F4"]'
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5 '["<Control><Shift>F5"]'
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6 '["<Control><Shift>F6"]'
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-7 '["<Control><Shift>F7"]'
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-8 '["<Control><Shift>F8"]'
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-9 '["<Control><Shift>F9"]'
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-10 '["<Control><Shift>F10"]'
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-11 '["<Control><Shift>F11"]'
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-12 '["<Control><Shift>F12"]'

