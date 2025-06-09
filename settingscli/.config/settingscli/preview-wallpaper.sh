#!/bin/bash

CONFIG_FILE="$HOME/.config/settingscli/config"

# Default to viu
PREVIEWER="viu"

# Load config if it exists
[[ -f "$CONFIG_FILE" ]] && source "$CONFIG_FILE"

case "$PREVIEWER" in
  kitty)
    if command -v kitty &>/dev/null; then
      kitty +kitten icat "$1"
    else
      echo "Kitty not available, fallback to viu."
      viu "$1"
    fi
    ;;
  viu)
    if command -v viu &>/dev/null; then
      viu "$1"
    else
      echo "'viu' is not installed. Please install it with: sudo pacman -S viu"
      exit 1
    fi
    ;;
  chafa)
    if command -v chafa &>/dev/null; then
      chafa "$1"
    else
      echo "'chafa' is not installed. Please install it."
      exit 1
    fi
    ;;
  *)
    echo "Unknown previewer: $PREVIEWER"
    exit 1
    ;;
esac

read -n 1 -s -r -p "Press any key to return to selection..."
