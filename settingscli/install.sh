#!/bin/bash
set -e

echo "Installing settingscli..."

INSTALL_DIR="$HOME/.config/settingscli"
BIN_LINK="$HOME/.local/bin/settingscli"
DESKTOP_FILE="$HOME/.local/share/applications/settingscli.desktop"

mkdir -p "$INSTALL_DIR"
mkdir -p "$(dirname "$BIN_LINK")"
mkdir -p "$(dirname "$DESKTOP_FILE")"

cp settingscli.sh "$INSTALL_DIR/"
cp preview-wallpaper.sh "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/"*.sh

ln -sf "$INSTALL_DIR/settingscli.sh" "$BIN_LINK"

cp settingscli.desktop "$DESKTOP_FILE"
chmod +x "$DESKTOP_FILE"

echo "✅ settingscli installed."
echo "▶ Run it with: settingscli"
