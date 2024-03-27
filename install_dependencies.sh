!#/bin/bash
# echo Installing Flatpak packages"
# flatpak install flathub com.github.wwmm.easyeffects dev.vencord.Vesktop
###### Neovim Plugins #####
# After instaling run :PlugInstall in neovim
#mkdir ~/.config/nvim/ && cd ~/.config/nvim
echo "\
Before using this script you need to get the following WM: BSPWM
Furthermore you need to install the following packages:
    - autorandr (Pacman)
    - brave-bin (Pacman)
    - brightnessctl (Pacman)
    - ctags (Pacman)
    - Neovim and Vim-plug (https://github.com/junegunn/vim-plug)
    - Customizable GRUB Theme (https://github.com/mateosss/matter)
    - Rofi (Pacman)
    - picom (Pacman)
    - xclip (Pacman)
    - oh-my-zsh-git (Pacman)
    - zsh-autosuggestions-git (Pacman)
    - zsh-history-substring-search-git (Pacman)
    - zsh-syntax-highlighting (Pacman)
    - ttf-jetbrains-mono (Pacman)
    - ttf-nerd-fonts-symbols (Pacman)
    - conky-lua-archers (Pacman)
    - flatpak (pacman)
    - com.github.wwmm.easyeffects (Flatpak)
    - SDDM Arcolinux-sugar-candy

    
Do you want to install pre-requirements? [Y/N]:
        "
read requirements
case $requirements in
    [Yy]* )
        echo "Installing Pacman packages"
        sudo pacman -S --needed arcolinux-sddm-sugar-candy-git autorandr brave-bin \
            brightnessctl ctags neovim rofi picom xclip ttf-jetbrains-mono \
            ttf-nerd-fonts-symbols conky-lua-archers \
            flatpak numix-icon-theme-git oh-my-zsh-git zsh-autosuggestions-git \
            zsh-syntax-highlighting zsh-history-substring-search-git
        if [ -n "$ZSH_VERSION" ]; then
            echo "Current shell is ZSH, skipping activation..."
        else
            echo "Activating ZSH"
            sudo chsh -s /bin/zsh $(whoami)
        fi
        ;;
    [Nn]* ) 
        echo "Make sure to install the requirements"
        ;;
    * ) echo "Do you want to install pre-requirements? [Y/N]:" ;;
esac

echo "Do you want to install Neovim Plugins? [Y/N]:"
read nvim_plug
case $nvim_plug in
    [Yy]* )
        echo "Installing Neovim Plugins"
        if [ ! -d "$HOME/.local/share/nvim/site/autoload" ]; then
            sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        fi
        nvim --headless +PlugInstall \
            +"CocInstall coc-clangd coc-json coc-tsserver coc-pyright" \
            +qa
        #You need add +q to the end in order to kill the process when done. You can run all commands this way (by prepending a plus sign to each).
        ;;
    [Nn]* )
        echo "Nothing more to do."
        ;;
    * ) echo "Do you want to install Neovim Plugins? [Y/N]:" ;;
esac

echo "Do you want to configure GRUB? [Y/N]:"
read grub
case $grub in
    [Yy]* )
        if [ ! -d "$HOME/Documents/GRUB-matter" ]; then 
            git clone https://github.com/mateosss/matter $HOME/Documents/GRUB-matter/
        fi
        #TODO Colores leidos de archivo
	    echo "The following grub entries are available"
	    sudo ~/Documents/GRUB-matter/matter.py -l
	    echo "Type the icons you want to use separated byspace (for example: arch arch _ _ _ _ _ _ microsoft-windows cog restart power):"
	    read icons
        sudo ~/Documents/GRUB-matter/matter.py \
		    -i $icons \
		    -fg F9F5D7 -hl 3C3836 -bg 1E2021 -ic D3859B -fs 24
        ;;
    [Nn]* )
        echo "Nothing more to do."
        ;;
    * ) echo "Do you want to configure GRUB? [Y/N]:" ;;
esac
