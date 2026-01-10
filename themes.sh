#!/bin/bash

set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"
THEMES_DIR="$HOME/.themes"

# ==================================================
# UI helpers
# ==================================================
msg() {
    echo -e "\e[1;32m> $1\e[0m"
}

warn() {
    echo -e "\e[1;33m⚠ $1\e[0m"
}

# ==================================================
# Repositórios
# ==================================================
GTK_THEMES=(
    "https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme.git"
    "https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme.git"
    "https://github.com/Fausto-Korpsvart/Tokyonight-GTK-Theme.git"
    "https://github.com/Fausto-Korpsvart/Everforest-GTK-Theme.git"
)

PLAIN_THEMES=(
    "https://github.com/i-mint/midnight.git"
)

# ==================================================
# Funções
# ==================================================
clone_themes() {
    msg "Clonando temas"

    mkdir -p "$DOTFILES_DIR"

    for repo in "${GTK_THEMES[@]}" "${PLAIN_THEMES[@]}"; do
        name="$(basename "$repo" .git)"
        target="$DOTFILES_DIR/$name"

        if [[ -d "$target" ]]; then
            warn "Já existe: $name (pulando clone)"
        else
            git clone "$repo" "$target"
        fi
    done
}

install_gtk_themes() {
    msg "Instalando temas GTK"

    for repo in "${GTK_THEMES[@]}"; do
        name="$(basename "$repo" .git)"
        theme_dir="$DOTFILES_DIR/$name"

        if [[ -f "$theme_dir/themes/install.sh" ]]; then
            msg "Instalando $name"
            (
                cd "$theme_dir/themes"
                bash install.sh
            )
            rm -rf "$theme_dir"
        else
            warn "$name não possui install.sh"
        fi
    done
}

install_plain_themes() {
    msg "Instalando temas sem script"

    mkdir -p "$THEMES_DIR"

    for repo in "${PLAIN_THEMES[@]}"; do
        name="$(basename "$repo" .git)"
        theme_dir="$DOTFILES_DIR/$name"

        if [[ -d "$theme_dir" ]]; then
            msg "Instalando $name"
            mv "$theme_dir/"* "$THEMES_DIR/"
            rm -rf "$theme_dir"
        else
            warn "$name não encontrado"
        fi
    done
}

check_dependencies() {
    command -v git >/dev/null || {
        echo "git não está instalado"
        exit 1
    }
}

# ==================================================
# Execução
# ==================================================
check_dependencies
clone_themes
install_gtk_themes
install_plain_themes

msg "Todos os temas foram instalados com sucesso 🎉"