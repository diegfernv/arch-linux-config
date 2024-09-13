#!/bin/bash

# start waybar if not started
if ! pgrep -x "waybar" > /dev/null; then
	waybar &
fi

# Array of confijg files to monitor
config_files=(
    ~/.config/waybar/config.jsonc
    ~/.config/waybar/style.css
    ~/.config/waybar/modules.json
    ~/.config/waybar/custom_modules.json
    )

# Function to calculate checksums of all files
calculate_checksums() {
    checksums=()
    for file in "${config_files[@]}"; do
        if [ -f "$file" ]; then
            checksums+=("$(md5sum "$file")")
        else
            checksums+=("missing")
        fi
    done
}

# Initialize current checksums
calculate_checksums
current_checksums=("${checksums[@]}")


# loop forever
while true; do
    # Calculate new checksums
    calculate_checksums
    new_checksums=("${checksums[@]}")

    # Check if checksums are different
    checksum_changed=false
    for i in "${!current_checksums[@]}"; do
        if [ "${current_checksums[$i]}" != "${new_checksums[$i]}" ]; then
            checksum_changed=true
            break
        fi
    done

    # If any checksum changed, restart waybar
	if [ "$checksum_changed" = true ]; then
		# kill waybar
		killall waybar

		# start waybar
		waybar &

		# update checksums
        current_checksums=("${new_checksums[@]}")
	fi

    sleep 2
done
