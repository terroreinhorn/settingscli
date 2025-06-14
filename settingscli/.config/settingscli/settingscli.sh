#!/bin/bash

# Save terminal buffer
tput smcup

# Color codes
RED="\e[31m"
GREEN="\e[32m"
CYAN="\e[36m"
YELLOW="\e[33m"
RESET="\e[0m"

# Menu entries
declare -A actions=(
  ["   System status (btop)"]="btop"
  ["   Network settings (nmtui)"]="nmtui"
  ["   Audio settings (alsamixer)"]="alsamixer"
  ["   Power profile (powerprofilesctl)"]="powerprofiles"
  ["   Disk usage analysis (ncdu)"]="ncdufull"
  ["   Bluetooth manager"]="bluetoothctl"
  ["   Change user password"]="passwdchange"
  ["   Manage services (systemctl)"]="systemctlcmd"
  ["   Package manager (pacseek)"]="pacseek"
  ["🎨  Set wallpaper (matugen)"]="matugenwall"
  ["   Exit"]="exit"
)

# Build sorted menu list
menu_items=$(for key in "${!actions[@]}"; do
  [[ ${actions[$key]} != "exit" ]] && echo "$key"
done | sort)
menu_items="${menu_items}"$'\n'"   Exit"

# Main loop
while true; do
  choice=$(printf '%s\n' "$menu_items" | \
    fzf --ansi \
        --prompt="🛠  Control Panel: " \
        --height=100% --reverse \
        --color=fg+:green,bg+:black,hl+:yellow \
        --header="↑↓ navigate • Enter select • Ctrl+E preview • Ctrl+C/ESC quit" \
        --bind=ctrl-m:accept
  )

  [[ -z "$choice" ]] && echo -e "\n${YELLOW}Exited.${RESET}\n" && break

  action="${actions[$choice]}"

  case "$action" in
    btop) btop ;;
    nmtui) nmtui ;;
    alsamixer) alsamixer ;;
    powerprofiles)
      echo -e "\n${CYAN}Available power profiles:${RESET}\n"
      powerprofilesctl list
      echo
      read -rp "Set profile (e.g. 'performance'): " profile
      sudo powerprofilesctl set "$profile"
      read -rp "Press Enter to return..." ;;
    bluetoothctl) bluetoothctl ;;
    passwdchange)
      read -rp "Username: " user
      sudo passwd "$user"
      read -rp "Press Enter to return..." ;;
    systemctlcmd)
      read -rp "systemctl command (e.g. 'restart bluetooth'): " cmd
      sudo systemctl $cmd
      echo
      read -rp "Press Enter to return..." ;;
    pacseek) pacseek ;;
    ncdufull) sudo ncdu / ;;
matugenwall)
  wallpaper=$(find "$HOME/Bilder/Wallpapers" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | sort | \
    while read -r path; do
      echo "$(basename "$path")|$path"
    done | \
    fzf --prompt="🎨  Choose a wallpaper: " \
        --height=100% --reverse \
        --with-nth=1 \
        --delimiter="|" \
        --bind "ctrl-e:execute(kitty @ launch --type=overlay --title 'Wallpaper Preview' bash -c '$HOME/.config/settingscli/preview-wallpaper.sh \"\$0\"' {2})" \
        --header="[Enter] apply • [Ctrl+E] preview • [ESC] cancel" \
        --ansi
  )

  selected_path=$(echo "$wallpaper" | cut -d '|' -f2)

  if [[ -n "$selected_path" ]]; then
    matugen image "$selected_path"
    echo -e "${GREEN}Wallpaper set:${RESET} $selected_path"
    sleep 1.5
  fi
  ;;

    exit)
      echo -e "${GREEN}Goodbye!${RESET}"
      break ;;
    *)
      echo -e "${RED}Unknown selection${RESET}" ;;
  esac
done

# Restore terminal buffer
tput rmcup

