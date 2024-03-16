!#/bin/bash
declare -a paths=( 
    ".config/bspwm/sxhkd/sxhkdrc" "bspwm/sxhkd/sxhkdrc" 
    ".config/bspwm/system-overview" "bspwm/system-overview"
    ".config/bspwm/scripts/monitor_connected.sh" "bspwm/scripts/monitor_connected.sh"
    ".config/bspwm/picom.conf" "bspwm/picom.conf"
    ".config/bspwm/autostart.sh" "bspwm/autostart.sh"
    ".config/bspwm/bspwmrc" "bspwm/bspwmrc"
    ".config/autorandr/." "autorandr/." 
    ".config/polybar/rosemary/." "polybar/rosemary/."
    ".config/alacritty/alacritty.toml" "alacritty/alacritty.toml"
    ".config/nvim/init.vim" "nvim/init.vim"
    ".themes/." "gtk-themes/."
    "Pictures/Wallpaper/." "wallpaper/."
    ".zshrc" "zsh/.zshrc"
    ".config/neofetch/config.conf" "neofetch/config.conf"
)
# Anadir esto pero primero ver si puedo dejarlo en .local o algo
    #"/usr/share/sddm/themes/arcolinux-sugar-candy/"
scriptDir="$(pwd)/"

max_paths=${#paths[@]}

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
            mkdir -p $(dirname $destination) && cp -r --update=all "$source" "$destination"
            echo "Copied $(echo $source | sed "s/.*\///") to $(dirname $destination)"
        done
        break
        ;;
    "2")
        chmod 700 ./install_dependencies.sh
        ./install_dependencies.sh
        echo "Copy configuration files? [Y/N]"
        read copy
        case $copy in
            [Yy]* )
                find ./{bspwm,polybar} -name "*.sh" -exec chmod 700 {} \;
                for ((i = 0; i < max_paths - 1; i+=2 )); do
                    source=./"${paths[$i+1]}"
                    destination=$HOME/"${paths[$i]}"
            
                    eval destination="$destination"
                    if [ -e "$destination" ]; then
                        # Puedo crear y copiar en 1 liner sin embargo, no lo hare de momento...
                        # mkdir -p $(dirname $destination) && cp -rv --update=all $source $destination"
                        cp -r --update=all "$source" "$destination"
                        echo "Copied $(echo $source | sed "s/.*\///") to $(dirname $destination)"
                    else
                        echo "Destination path $destination does not exist, skipping..."
                    fi 
                done
                break
                ;;
            [Nn]* )
                echo "Nothing more to do."
                break
                ;;
            * ) echo "Copy configuration files? [Y/N]"
        esac
        break
        ;;
    *) echo "Invalid option";;
esac

echo "All done!"
exit
