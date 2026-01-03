#!/bin/bash

# Dotfiles - Script de pós-instalação
# Autor: João Paulo
# Objetivo: Setup pessoal (Ubuntu-based)

# Definição do pipefail para capturar erros.
set -euo pipefail

# ==================================================
# CONFIGURAÇÕES
# ==================================================

PROJECTS_DIR="$HOME/Projects"
WAL_VENV="$HOME/wal_venv"
BASHRC="$HOME/.bashrc"

APT_PACKAGES=(
    adb brasero cava cowsay cmatrix extrepo fastfetch figlet gddrescue gimp git gparted gsmartcontrol 
    guvcview htop iftop keepassxc kitty krita neovim nmap obs-studio openjdk-25-jdk 
    piper python3-pip python3-venv ranger rkhunter scrcpy sqlitebrowser sqlite3 
    steghide syncthing syncthing-gtk tmux tty-clock veracrypt vrms vlc whois xournalpp
)

FLATPAK_PACKAGES=(
    com.github.wwmm.easyeffects com.jetbrains.IntelliJ-IDEA-Ultimate net.cozic.joplin_desktop
    net.opentabletdriver.OpenTabletDriver 
)

PPAS=(
    "ppa:obsproject/obs-studio"
    "ppa:phoerious/keepassxc"
    "ppa:unit193/encryption"
    "ppa:zhangsongcui3371/fastfetch"
)

# ==================================================
# Funções Auxiliares
# ==================================================
msg() {
    echo -e "\e[1;32m> $1\e[0m"
}

warn() {
    echo -e "\e[1;33m⚠ $1\e[0m"
}

# ==================================================
# Funções
# ==================================================
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
    for ppa in "${PPAS[@]}"; do    
        sudo add-apt-repository -y "$ppa" 
        msg "PPA $ppa configurada"
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
    sudo apt install -y "${APT_PACKAGES[@]}"    
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
    flatpak install -y flathub "${FLATPAK_PACKAGES[@]}"
}

setup_pywal(){
    msg "Configurando PyWal"
    python3 -m venv "$WAL_VENV"
    source "$WAL_VENV/bin/activate"
    pip install --upgrade pip
    pip install pywal16 colorz
    deactivate
}

lunarvim_install(){
    msg "Instalando LunarVim"
    LV_BRANCH='release-1.4/neovim-0.9' bash <(
        curl -fsSL https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh
    )     
}

bash_modification() {
    msg "Aplicando configurações no .bashrc"

    grep -q "---- LunarVim ----" "$BASHRC" || {
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

    warn "Reinicie o terminal para aplicar as alterações do bash"
}

git_clone(){
    msg "Clonando repositórios"

    mkdir -p "$PROJECTS_DIR"
    cd "$PROJECTS_DIR"

    git clone https://github.com/Atn4s/scava.sh.git || true
    git clone https://github.com/Atn4s/NoSpyCam.git || true
    git clone https://github.com/Atn4s/Daemon-HubUSB.C.git || true

    [[ -f .bash_aliases ]] && mv .bash_aliases "$HOME"
    [[ -d .config ]] && cp -r .config/* "$HOME/.config/"

    msg "Repositórios clonados em $PROJECTS_DIR"
}

# ==================================================
# EXECUÇÃO
# ==================================================
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