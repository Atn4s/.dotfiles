#!/bin/bash

# ----------------- CONFIGURAÇÕES -----------------

# Lista de pacotes APT
varApt=(
    adb cava cowsay cmatrix extrepo fastfetch figlet gimp git gparted gsmartcontrol 
    guvcview htop iftop keepassxc kitty krita neovim nmap obs-studio openjdk-21-jdk 
    piper python3-pip python3-venv ranger rkhunter scrcpy sqlitebrowser sqlite3 
    steghide syncthing syncthing-gtk tty-clock veracrypt vrms vlc whois xournalpp
)

# Lista de pacotes Flatpak
varFlatpak=(
    com.github.wwmm.easyeffects com.jetbrains.IntelliJ-IDEA-Ultimate net.cozic.joplin_desktop
    net.opentabletdriver.OpenTabletDriver 
)

# PPAs a serem adicionadas
varPPAs=(
    "ppa:obsproject/obs-studio"
    "ppa:phoerious/keepassxc"
    "ppa:unit193/encryption"
    "ppa:zhangsongcui3371/fastfetch"
)

# ----------------- FUNÇÕES -----------------

header(){
    clear
    echo -e "\e[1;34m"
    echo "    ___   __        __ __         ____        __  _____ __         "
    echo "   /   | / /_____  / // / _____  / __ \____  / /_/ __(_) /__  _____"
    echo "  / /| |/ __/ __ \/ // /_/ ___/ / / / / __ \/ __/ /_/ / / _ \/ ___/"
    echo " / ___ / /_/ / / /__  __(__  ) / /_/ / /_/ / /_/ __/ / /  __(__  ) "
    echo "/_/  |_\__/_/ /_/  /_/ /____(_)_____/\____/\__/_/ /_/_/\___/____/  "
    echo -e                                                                   
}

# Adiciona os PPAs
add_ppas(){
    echo -e "\e[1;32m> Adicionando PPAs...\e[0m"
    for ppa in "${PPAS[@]}"; do
        sudo add-apt-repository -y "$ppa" && echo "✔ PPA $ppa adicionada com sucesso!"
    done
}

# Atualização e Upgrade de pacotes
update_system(){
    echo -e "\e[1;32m> Atualizando o sistema...\e[0m"
    sudo apt update && sudo apt upgrade -y 
    flatpak upgrade -y
}

#Instalação de pacotes APT
install_apt_packages(){
    echo -e "\e[1;32m> Instalando pacotes APT...\e[0m"
    sudo apt install "${varApt[@]}"
}

# Habilitando repositório extrepo
enable_extrepo(){
    echo -e "\e[1;32m> Habilitando repositórios externos...\e[0m"
    sudo extrepo update
    sudo extrepo enable librewolf
    sudo apt update && sudo apt install librewolf
}

install_flatpak_packages(){
    echo -e "\e[1;32m> Instalando pacotes Flatpak...\e[0m"
    flatpak install "${varFlatpak[@]}"      
}

setup_pywal(){
    echo -e "\e[1;32m> Configurando PyWal...\e[0m"
    python3 -m venv $HOME/wal_venv/
    source $HOME/wal_venv/bin/activate
    pip install pywal
    deactivate
}
                                 
git_clone(){
    echo -e "\e[1;32m> Clonando outros repositórios\e[0m"    
    git clone https://github.com/Atn4s/scava.sh.git
    git clone https://github.com/Atn4s/NoSpyCam.git
    git clone https://github.com/Atn4s/Daemon-HubUSB.C.git

    mv .bash_aliases $HOME
    echo "✔ .bash_aliases adicionado!"

    cp -r .config/* $HOME/.config/
    echo "✔ Arquivos de configuração adicionados!"
}

# ----------------- EXECUÇÃO -----------------

header
add_ppas
update_system
enable_extrepo
install_apt_packages
install_flatpak_packages
setup_pywal
git_clone                     
echo -e "\e[1;32m✔ Seu sistema está pronto para uso!\e[0m"