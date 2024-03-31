!#/bin/bash
declare -a paths=( 
    ".config/bspwm/sxhkd/sxhkdrc" "bspwm/sxhkd/sxhkdrc" 
    ".config/bspwm/system-overview" "bspwm/system-overview"
    ".config/bspwm/scripts/monitor_connected.sh" "bspwm/scripts/monitor_connected.sh"
    ".config/bspwm/picom.conf" "bspwm/picom.conf"
    ".config/bspwm/autostart.sh" "bspwm/autostart.sh"
    ".config/bspwm/bspwmrc" "bspwm/bspwmrc"
    ".config/bspwm/wallpaper/." "bspwm/wallpaper/."
    ".config/autorandr/." "autorandr/." 
    ".config/polybar/rosemary/." "polybar/rosemary/."
    ".config/alacritty/alacritty.toml" "alacritty/alacritty.toml"
    ".config/nvim/." "nvim/."
    ".themes/." "gtk-themes/."
    ".zshrc" "zsh/.zshrc"
    ".config/neofetch/config.conf" "neofetch/config.conf"
    "../../usr/share/sddm/themes/arcolinux-sugar-candy/theme.conf" "arcolinux-sugar-candy/theme.conf"
    "../../usr/share/sddm/themes/arcolinux-sugar-candy/images/background08.jpg" "arcolinux-sugar-candy/background08.jpg"
    "../../etc/sddm.conf.d/kde_settings.conf" "arcolinux-sugar-candy/kde_settings.conf"
    ".icons/rosemary-pink/." "icons/."
    ".config/coc/." "coc/."
)
# Anadir esto pero primero ver si puedo dejarlo en .local o algo
    #"/usr/share/sddm/themes/arcolinux-sugar-candy/"
scriptDir="$(pwd)/"

max_paths=${#paths[@]}

# Check if the script is run as root
if [ "$EUID" -eq 0 ]; then
    echo "This script cannot be run with root privileges."
    exit 1
fi

echo "\
This script is a 2 way copy, it's functions are:
    1. Retrieve all configuration files (Master PC to Github)
    2. Deliver all configuration files (Github to child PC)
What would you like to do? (Type 1 or 2): "
read choice
case $choice in
    "1")
        for ((i = 0; i < max_paths - 1; i+=2 )); do
            source=$HOME/"${paths[$i]}"
            destination=./"${paths[$i+1]}"
            
            eval source="$source"
            sudo mkdir -p $(dirname $destination) && sudo cp -r --update=all "$source" "$destination"
            echo "Copied $(echo $source | sed "s/.*\///") to $(dirname $destination)"
        done
        ;;
    "2")
        chmod 700 ./install_dependencies.sh
        ./install_dependencies.sh
        echo "Copy configuration files? [Y/N]"
        read copy
        case $copy in
            [Yy]* )
                find ./{bspwm,polybar} -name "*.sh" -exec chmod 755 {} \;
                for ((i = 0; i < max_paths - 1; i+=2 )); do
                    source=./"${paths[$i+1]}"
                    destination=$HOME/"${paths[$i]}"
            
                    eval destination="$destination"
			        sudo mkdir -p $(dirname $destination) && sudo cp -r --update=all "$source" "$destination"
                        echo "Copied $(echo $source | sed "s/.*\///") to $(dirname $destination)"
                done
                ;;
            [Nn]* )
                echo "Nothing more to do."
                ;;
            * ) echo "Copy configuration files? [Y/N]" ;;
        esac
        echo "Run Neovim configuration? [Y/N]:"
        read config
        case $config in
            [Yy]* )
                nvim --headless -c "PlugInstall" -c "qa"
                nvim --headless -c "CocInstall coc-clangd coc-json coc-tsserver coc-pyright" -c "qa"
                ;;
            [Nn]* )
                echo "Nothing More to do."
                ;;
            * ) echo "Run Neovim configuration? [Y/N]:" ;;
        esac
        ;;
    *) echo "Invalid option";;
esac

echo "All done!"
exit
