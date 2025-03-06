#!/bin/bash

# Packages and tools 
varApt=(
    adb cava cowsay cmatrix extrepo fastfetch figlet gimp git gparted gsmartcontrol 
    guvcview htop iftop keepassxc kitty krita neovim nmap obs-studio openjdk-21-jdk 
    piper python3-pip python3-venv ranger rkhunter scrcpy sqlitebrowser sqlite3 
    steghide syncthing syncthing-gtk tty-clock veracrypt vrms vlc whois xournalpp
)

varFlatpak=(
    com.getpostman.Postman com.spotify.Client md.obsidian.Obsidian net.mullvad.MullvadBrowser net.opentabletdriver.OpenTabletDriver org.apache.netbeans
)

varPPAs=(
    "ppa:phoerious/keepassxc"
    "ppa:unit193/encryption"
    "ppa:zhangsongcui3371/fastfetch"
)

enable_extrepo(){
    sudo extrepo update
}

PythonImage(){
    python3 -m venv $HOME/wal_venv/
    source $HOME/wal_venv/bin/activate
    pip install pywal
    deactivate
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

enable_extrepo

echo -e "> Installing Flatpak programs"
flatpak install "${varFlatpak[@]}"                                                                    
                          
echo -e "> Adding my scripts"               

git clone https://github.com/Atn4s/scava.sh.git
git clone https://github.com/Atn4s/NoSpyCam.git
git clone https://github.com/Atn4s/Daemon-HubUSB.C.git

mv .bash_aliases $HOME
echo -e "> .bash_aliases added"

cp -r .config/ ~/
echo -e "> .config files are now added to the system"

PythonImage

echo -e "[ Your Distro is ready to go! ]"