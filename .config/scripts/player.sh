#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 --title | --artist | --length | --status | --album | --source"
    exit 1
}

# Check if no arguments are provided
if [ $# -eq 0 ]; then
    usage
fi

# Function to get metadata using playerctl
get_metadata() {
    key=$1
    playerctl metadata --format "{{ $key }}" 2>/dev/null
}

# Function to determine the source and return an icon and text
get_source_info() {
    trackid=$(get_metadata "mpris:trackid")
    case "$trackid" in
        *firefox*)
            echo -e "Firefox 󰈹"
            ;;
        *spotify*)
            echo -e "   Spotify "
            ;;
        *chromium*)
            echo -e "Chrome "
            ;;
        *)
            echo ""
            ;;
    esac
}

# Parse the argument
case "$1" in
    --title)
        title=$(get_metadata "xesam:title")
        echo "${title:0:50}"  # Limit the output to 50 characters
        ;;
    --artist)
        artist=$(get_metadata "xesam:artist")
        echo "${artist:0:50}"  # Limit the output to 50 characters
        ;;
    --length)
        length=$(get_metadata "mpris:length")
        if [ -n "$length" ]; then
            # Convert length from microseconds to minutes and seconds format
            minutes=$(( $length / 1000000 / 60 ))
            seconds=$(( ($length / 1000000) % 60 ))
            printf "%d:%02d\n" $minutes $seconds
        else
            echo ""
        fi
        ;;
    --status)
        status=$(playerctl status 2>/dev/null)
        case "$status" in
            Playing)
                echo "   Playing"
                ;;
            Paused)
                echo "󰏤   Paused"
                ;;
            *)
                echo ""
                ;;
        esac
        ;;
    --album)
        album=$(get_metadata "xesam:album")
        if [ -n "$album" ]; then
            echo "$album"
        else
            echo "Unknown album"
        fi
        ;;
    --source)
        get_source_info
        ;;
    *)
        echo "Invalid option: $1"
        usage
        ;;
esac
