#!/bin/bash

# Definição do pipefail para capturar erros.
set -euo pipefail

# ----------------- CONFIGURAÇÕES -----------------

# Pacotes APT
varApt=(
    adb brasero cava cowsay cmatrix extrepo fastfetch figlet gddrescue gimp git gparted gsmartcontrol 
    guvcview htop iftop keepassxc kitty krita neovim nmap obs-studio openjdk-21-jdk 
    piper python3-pip python3-venv ranger rkhunter scrcpy sqlitebrowser sqlite3 
    steghide syncthing syncthing-gtk tmux tty-clock veracrypt vrms vlc whois xournalpp
)

# Pacotes Flatpak
varFlatpak=(
    com.github.wwmm.easyeffects com.jetbrains.IntelliJ-IDEA-Ultimate net.cozic.joplin_desktop
    net.opentabletdriver.OpenTabletDriver 
)

# PPAs
varPPAs=(
    "ppa:obsproject/obs-studio"
    "ppa:phoerious/keepassxc"
    "ppa:unit193/encryption"
    "ppa:zhangsongcui3371/fastfetch"
)

#------------ FUNÇÕES AUXILIARES ------------
msg() {
    echo -e "\e[1;32m> $1\e[0m"
}

warn() {
    echo -e "\e[1;33m⚠ $1\e[0m"
}

# ----------------- FUNÇÕES -----------------
header(){
    clear
    echo -e "\e[1;34m"
    cat <<'EOF'
    ___   __        __ __         ____        __  _____ __
   /   | / /_____  / // / _____  / __ \____  / /_/ __(_) /__  _____
  / /| |/ __/ __ \/ // /_/ ___/ / / / / __ \/ __/ /_/ / / _ \/ ___/
 / ___ / /_/ / / /__  __(__  ) / /_/ / /_/ / /_/ __/ / /  __(__  )
/_/  |_\__/_/ /_/  /_/ /____(_)_____/\____/\__/_/ /_/_/\___/____/
EOF
    echo -e "\e[0m"                                                                   
}

# Adiciona os PPAs
add_ppas(){
    msg "Adicionando PPAs"
    for ppa in "${varPPAs[@]}"; do    
        sudo add-apt-repository -y "$ppa" && echo "✔ PPA $ppa adicionada com sucesso!"
    done
}

# Atualização e Upgrade de pacotes
update_system(){
    msg "Atualizando sistema"
    sudo apt update 
    sudo apt upgrade -y 
    flatpak upgrade -y || true
}

#Instalação de pacotes APT
install_apt_packages(){
    msg "Instalando pacotes APT"
    sudo apt install -y "${varApt[@]}"    
}

# Habilitando repositório extrepo
enable_extrepo(){
    msg "Habilitando extrepo"
    sudo extrepo update
    sudo extrepo enable librewolf || true
    sudo apt update 
    sudo apt install -y librewolf
}

install_flatpak_packages(){
    msg "Configurando Flatpak"
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo    
    msg "Instalando pacotes Flatpak"
    flatpak install -y flathub "${varFlatpak[@]}"
}

setup_pywal(){
    msg "Configurando PyWal"
    python3 -m venv "$HOME/wal_venv"    
    source "$HOME/wal_venv/bin/activate"
    pip install --upgrade pip
    pip install pywal16 colorz
    deactivate
}

lunarvim_install(){
    msg "Instalando LunarVim"
    LV_BRANCH='release-1.4/neovim-0.9' bash <(
        curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh
    )     
}

bash_modification() {
    msg "Aplicando configurações no .bashrc"

    BASHRC="$HOME/.bashrc"

    {
        echo ""
        echo "# ---- PyWal ----"
        echo '[[ -f "$HOME/.cache/wal/sequences" ]] && cat "$HOME/.cache/wal/sequences"'
        echo '[[ -f "$HOME/.cache/wal/colors-tty.sh" ]] && source "$HOME/.cache/wal/colors-tty.sh"'

        echo ""
        echo "# ---- Terminal ----"
        echo 'export TERM=xterm-256color'

        echo ""
        echo "# ---- LunarVim ----"
        echo '[[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && export PATH="$HOME/.local/bin:$PATH"'
    } >> "$BASHRC"

    echo "Reinicie o terminal para aplicar as alterações do bash"
}

git_clone(){
    msg "Clonando repositórios"

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
lunarvim_install
bash_modification
git_clone                   
  
msg "Sistema pronto para uso"