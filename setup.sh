#!/bin/bash

# Packages and tools 
varApt=(
    adb cava cowsay cmatrix extrepo figlet gimp git gparted gsmartcontrol 
    guvcview htop iftop keepassxc kitty krita nmap obs-studio openjdk-21-jdk 
    piper python3-pip python3-venv ranger rkhunter scrcpy sqlitebrowser sqlite3 
    steghide tty-clock veracrypt vrms vlc whois xournalpp
)

varFlatpak=(
    com.getpostman.Postman com.spotify.Client net.opentabletdriver.OpenTabletDriver org.apache.netbeans    
)

varPPAs=(
    "ppa:phoerious/keepassxc"
    "ppa:unit193/encryption"
)

enable_librewolf(){
    sudo extrepo update
    sudo extrepo enable librewolf
    sudo apt update && sudo apt install librewolf
}

AppImages(){
    echo "Remember to Download these AppImages:"
    echo "Joplin, LocalSend, Obsidian"
}

# Main code
clear

echo "    ___   __        __ __         ____        __  _____ __         "
echo "   /   | / /_____  / // / _____  / __ \____  / /_/ __(_) /__  _____"
echo "  / /| |/ __/ __ \/ // /_/ ___/ / / / / __ \/ __/ /_/ / / _ \/ ___/"
echo " / ___ / /_/ / / /__  __(__  ) / /_/ / /_/ / /_/ __/ / /  __(__  ) "
echo "/_/  |_\__/_/ /_/  /_/ /____(_)_____/\____/\__/_/ /_/_/\___/____/  "
echo -e                                                                   
                                                                                          
echo -e "> Adding PPA's to the system"
for ppa in "${varPPAs[@]}"; do
    sudo add-apt-repository "$ppa"
done

echo -e "> Update and Upgrade APT and Flatpak"
sudo apt update && sudo apt upgrade && flatpak upgrade

echo -e "> Installing Apt programs"
sudo apt install "${varApt[@]}"
enable_librewolf

echo -e "> Installing Flatpak programs"
flatpak install "${varFlatpak[@]}"                                                                    
                          
echo -e "> Adding my scripts"               

git clone https://github.com/Atn4s/scava.sh.git
git clone https://github.com/Atn4s/NoSpyCam.git

mv .bash_aliases $HOME
echo -e "> .bash_aliases added"

cp -r .config/ ~/
echo -e "> .config files are now added to the system"

AppImages
echo -e "[ Your Distro is ready to go! ]"