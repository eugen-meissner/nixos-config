#!/usr/bin/env bash

# Wait a bit for Hyprland to fully initialize
sleep 2

# Start swww-daemon if not running
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon &
    # Wait for daemon to start and connect to wayland
    sleep 1
fi

# Read wallpaper path from config
CONFIG_FILE="$HOME/.config/waypaper/config.ini"
WALLPAPER_PATH=""

if [ -f "$CONFIG_FILE" ]; then
    # Extract wallpaper path from config (handles ~ expansion)
    WALLPAPER_PATH=$(grep "^wallpaper = " "$CONFIG_FILE" | sed 's/wallpaper = //' | tr -d ' ')
    # Expand ~ to home directory
    WALLPAPER_PATH="${WALLPAPER_PATH/#\~/$HOME}"
fi

# Fallback to default if not found or empty
if [ -z "$WALLPAPER_PATH" ] || [ ! -f "$WALLPAPER_PATH" ]; then
    WALLPAPER_PATH="$HOME/Pictures/wallpapers/others/nixos.png"
fi

# Set wallpaper if file exists
if [ -f "$WALLPAPER_PATH" ]; then
    swww img "$WALLPAPER_PATH" --transition-type any --transition-step 90 --transition-angle 0 --transition-duration 2 --transition-fps 60
else
    echo "Warning: Wallpaper file not found: $WALLPAPER_PATH" >&2
fi

