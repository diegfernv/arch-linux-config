#!/bin/bash

# Function to show usage information
usage() {
    echo "Usage:"
    echo -e "\t$0 COMMAND [COMMAND_OPTIONS]"
    echo "Commands:"
    echo -e "\t{up|down} <percentage>\t-- Increase or decrease the volume by the specified percentage"
    echo -e "\ttoggle                \t-- Toggle mute"
    echo -e "\tnext-sink             \t-- Switch to the next sink"
    echo -e "\tprevious-sink         \t-- Switch to the previous sink"
    exit 1
}

get_active_sink_number(){
    wpctl status | grep -A 5 "Sinks:" | grep "*" | awk '{print $3}' | tr -d '.'
}

get_active_sink_name(){
    wpctl status | grep -A 5 "Sinks:" | grep "*" | awk -F"   " '{print $2}' | sed 's/^[0-9]*\. //'
}

get_active_sink_output_name(){
    wpctl status | grep "Audio/Sink" | awk '{print $3}'
}

get_next_sink_number(){
    local current_sink=$(get_active_sink_number)
    local next_sink=$(wpctl status | grep -A 1 "$current_sink\. " | tail -n 1 | awk '{print $2}' | tr -d '.')
    if [[ ! "$next_sink" =~ ^[0-9]+$ ]]; then
        next_sink=$(wpctl status | grep -A 5 "Sinks:" | grep "[0-9]*\." | head -n 1 | awk '{print $2}' | tr -d '.')
    fi
    echo "$next_sink"
}

get_previous_sink_number(){
    local current_sink=$(get_active_sink_number)
    local previous_sink=$(wpctl status | grep -B 1 "$current_sink\. " | head -n 1 | awk '{print $2}' | tr -d '.')
    if [[ ! "$previous_sink" =~ ^[0-9]+$ ]]; then
        previous_sink=$(wpctl status | grep -B 2 "Sources:" | head -n 1 | awk '{print $2}' | tr -d '.')
    fi 
    echo "$previous_sink"
}

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    usage
fi

action=$1

case "$action" in
    up)
        percentage=$2
        # Validate the percentage input
        if ! [[ "$percentage" =~ ^[0-9]+$ ]]; then
            echo "Error: Percentage must be a positive integer."
            usage
        fi
        active_sink_number=$(get_active_sink_number)
        wpctl set-volume "$active_sink_number" "$percentage"%+
        ;;
    down)
        percentage=$2
        # Validate the percentage input
        if ! [[ "$percentage" =~ ^[0-9]+$ ]]; then
            echo "Error: Percentage must be a positive integer."
            usage
        fi
        active_sink_number=$(get_active_sink_number)
        wpctl set-volume "$active_sink_number" "$percentage"%-
        ;;
    toggle)
        active_sink_number=$(get_active_sink_number)
        wpctl set-mute "$active_sink_number" toggle
        ;;
    next-sink)
        echo "Switching to the next sink..."
        echo $(get_next_sink_number)
        wpctl set-default $(get_next_sink_number)
        ;;
    previous-sink)
        echo "Switching to the previous sink..."
        echo $(get_previous_sink_number)
        wpctl set-default $(get_previous_sink_number)
        ;;
    *)
        echo "Error: Invalid command."
        usage
        ;;
esac
