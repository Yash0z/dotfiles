#!/bin/env bash

THUMB=/tmp/cover

cleanup() {
    rm -f "${THUMB}.inf" "${THUMB}.png"
}

fetch_thumb() {
    artUrl=$(playerctl -p spotify metadata --format '{{mpris:artUrl}}')

    # Create ${THUMB}.inf if it doesn't exist
    touch "${THUMB}.inf"

    current_art=$(<"${THUMB}.inf")

    # Check if the current art URL matches the fetched one
    if [[ "${artUrl}" != "${current_art}" ]]; then
        printf "%s\n" "$artUrl" > "${THUMB}.inf"
        curl -so "${THUMB}.png.tmp" "$artUrl"
        magick "${THUMB}.png.tmp" -quality 50 "${THUMB}.png" && rm "${THUMB}.png.tmp"
        pkill -USR2 hyprlock
    fi
}

# Cleanup any existing image files
cleanup

# Monitor changes in metadata and update accordingly
while true; do
    playerctl -p spotify metadata --format '{{title}}    {{artist}}' > /dev/null 2>&1
    fetch_thumb
    sleep 2  # Adjust as needed for how often you want to check
done
