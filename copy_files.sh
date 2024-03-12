!#/bin/bash
declare -a paths=( 
    "~/.config/bspwm" "./bspwm" 
    "~/.config/autorandr" "./autorandr" 
    "~/.config/polybar" "./polybar"
    "~/.config/alacritty" "./alacritty"
    "~/.config/nvim/" "./nvim"
    "~/.themes" "./gtk-themes"
    "~/Pictures/Wallpaper/" "./wallpaper"
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
            source="${paths[$i]}"
            destination="${paths[$i+1]}"
            
            eval source="$source"
            if [ -e "$source" ]; then
                cp -r "$source" "$destination"
                echo "Copied $source to $destination"
            else
                echo "Source path $source does not exist"
            fi 
        done
        break
        ;;
    "2")
        echo "\
Before using this script you need to get the following WM: BSPWM
Furthermore you need to install thepackages:
    - autorandr (Pacman)
    - Neovim and Vim-plug (https://github.com/junegunn/vim-plug)
    - Customizable GRUB Theme (https://github.com/mateosss/matter)
    - Rofi (Pacman)
    - picom (Pacman)
    - xclip (Pacman)
    - jetbrains-mono-ttf (Pacman)
    - nerd-fonts-symbols (Pacman)
    - conky (Pacman)
    - com.github.wwmm.easyeffects (Flatpak)
    - SDDM Arcolinux-sugar-candy

    
Do you have all pre-requirements installed? [Y/N]:
        "
        read requirements
        case $requirements in
            [Yy]* )
                echo "You have selected Yes"
                for ((i = 0; i < max_paths - 1; i+=2 )); do
                    source="${paths[$i+1]}"
                    destination="${paths[$i]}"
            
                    eval source="$source"
                    if [ -e "$source" ]; then
                        cp -r "$source" "$destination"
                        echo "Copied $source to $destination"
                    else
                        echo "Source path $source does not exist"
                    fi 
                done
                break
                ;;
            [Nn]* ) 
                echo "Please install the requirements"
                exit
                break
                ;;
            * ) echo "Do you have all pre-requirements installed [Y/N]:";;
        esac
        break
        ;;
    *) echo "Invalid option";;
esac

echo "All done!"
exit
