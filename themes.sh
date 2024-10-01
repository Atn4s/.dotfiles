git clone https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme.git
git clone https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme.git
git clone https://github.com/Fausto-Korpsvart/Tokyonight-GTK-Theme.git
git clone https://github.com/Fausto-Korpsvart/Everforest-GTK-Theme.git
git clone https://github.com/i-mint/midnight.git

cd $HOME/.dotfiles/Catppuccin-GTK-Theme/themes &&  bash install.sh
rm -rf $HOME/.dotfiles/Catppuccin-GTK-Theme
cd $HOME/.dotfiles/Everforest-GTK-Theme/themes &&  bash install.sh
rm -rf $HOME/.dotfiles/Everforest-GTK-Theme
cd $HOME/.dotfiles/Tokyonight-GTK-Theme/themes &&  bash install.sh
rm -rf $HOME/.dotfiles/Tokyonight-GTK-Theme
mv $HOME/.dotfiles/midnight/* $HOME/.themes/
rm -rf $HOME/.dotfiles/midnight