# settingscli

`settingscli` is a universal, nerd-font-based terminal control panel written in Bash and powered by `fzf`.
It provides quick access to essential system tools, service management, wallpaper switching (with preview), and more – all from a clean CLI interface.

---

## 🖼️ Screenshots

### Main Menu
![main](screenshots/menu.png)

### Wallpaper Selection
![wallpapers](screenshots/wallpaper-list.png)

### Wallpaper Preview
![preview](screenshots/preview.png)

---

## ✨ Features

- Fast keyboard-based system control via `fzf`
- Audio, network, systemd, power profile and package management
- Universal wallpaper switcher with preview
- Compatible with many terminal emulators
- Customizable preview backend (`kitty`, `viu`, `chafa` etc.)

---

## 📦 Installation

```bash
git clone https://github.com/terroreinhorn/settingscli
cd settingscli
bash install.sh
```

---

## ⚙️ Requirements

- `bash`
- `fzf`
- `viu` (for image previews)
- (Optional) `kitty` or `chafa` for advanced previewing
- Common tools: `btop`, `nmtui`, `alsamixer`, `powerprofilesctl`, `bluetoothctl`, `systemctl`, `pacseek`, `matugen`

---

## 🔧 Configuration

On first run, you'll be asked where your wallpapers are stored.
The path is saved to: `~/.config/settingscli/config`

You can also manually define:

```bash
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
PREVIEWER="viu"  # or: kitty, chafa
```

---

## 🚀 Launch

You can start `settingscli` via:

```bash
settingscli
```

Or using your system launcher (a `.desktop` file is included).

---

## 📄 License

GPL-3.0
