#!/bin/bash

varApt=(
    adb
    cava
    cowsay
    cmatrix
    figlet
    git
    gparted
    gsmartcontrol
    guvcview
    htop
    iftop
    keepassxc
    kitty
    nmap
    obs-studio 
    openjdk-21-jdk
    python3-pip
    python3-venv
    ranger
    rkhunter
    scrcpy
    sqlitebrowser
    sqlite3
    syncthing
    syncthing-gtk
    steghide
    tty-clock
    veracrypt
    vrms
    vlc
    whois
    xournalpp
)

varFlatpak=(
    com.getpostman.Postman
    io.gitlab.librewolf-community
    md.obsidian.Obsidian
    net.cozic.joplin_desktop
    net.opentabletdriver.OpenTabletDriver
    org.apache.netbeans    
)

varPPAs=(
    "ppa:phoerious/keepassxc"
    "ppa:unit193/encryption"
)

clear

echo "   ___  _           ___             "
echo "  / _ \| |         /   |            "
echo " / /_\ \ |_ _ __  / /| |___         "
echo " |  _  | __| '_ \/ /_| / __|        "
echo " | | | | |_| | | \___  \__ \        "
echo " \_| |_/\__|_| |_|   |_/___/        "
echo "                                    "
echo " ______      _    __ _ _            "
echo " |  _  \    | |  / _(_) |           "
echo " | | | |___ | |_| |_ _| | ___  ___  "
echo " | | | / _ \| __|  _| | |/ _ \/ __| "
echo " | |/ / (_) | |_| | | | |  __/\__ \ "
echo " |___/ \___/ \__|_| |_|_|\___||___/ "
echo "                                    "
                                                                                          
echo -e
echo "> Adding PPA's to the system"
for ppa in "${varPPAs[@]}"; do
    sudo add-apt-repository "$ppa"
    echo "TEST"
done

echo -e
echo "> Update and Upgrade APT and Flatpak"
sudo apt update && sudo apt upgrade && flatpak upgrade

echo -e
echo "> Installing Apt programs"
sudo apt install "${varApt[@]}"

echo -e
echo "> Installing Flatpak programs"
flatpak install "${varFlatpak[@]}"                                                                    
                          
echo "> Adding my scripts"               

git clone https://github.com/Atn4s/scava.sh.git
git clone https://github.com/Atn4s/NoSpyCam.git

mv .bash_aliases $HOME
echo "> .bash_aliases added"

echo "[ Your Distro is ready to go! ]"

