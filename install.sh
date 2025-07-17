#!/bin/bash

set -e

echo "==> Starting Teal-Memory setup..."

# === 1. Required packages ===
echo "==> Installing base packages..."

PKGS=(
  git
  hyprland
  waybar
  kitty
  dolphin
  btop
  neofetch
  zsh
  nautilus
  neovim
  curl
  wget
  wl-clipboard
  rofi
  dunst
  swaync
  wlogout
  qt6ct
  gtk3
  gtk4
  go
  systemd
)

sudo pacman -Syu --needed --noconfirm "${PKGS[@]}"

# === 2. Optional AUR support ===
if ! command -v yay &> /dev/null; then
  echo "==> Installing yay AUR helper..."
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay
  makepkg -si --noconfirm
  cd ~
fi

# === 3. Clone repo if needed ===
if [ ! -d "$HOME/Teal-Memory" ]; then
  echo "==> Cloning dotfiles repo..."
  git clone git@github.com:BrianPalacio/Teal-Memory.git "$HOME/Teal-Memory"
fi

# === 4. Copy config folders ===
echo "==> Copying config files to ~/.config..."

CONFIGS=(
  bashrc btop com.ml4w.hyprlandsettings dconf dotfiles dunst fastfetch go
  gtk-3.0 gtk-4.0 hypr kde.org libreoffice matugen ml4w nautilus
  nwg-dock-hyprland nwg-look ohmypolish pulse qt6ct rofi session swaync
  systemd vim wal waybar waypaper wlogout xsettingsd yay zshrc
)

mkdir -p "$HOME/.config"

for folder in "${CONFIGS[@]}"; do
  echo "  -> $folder"
  rm -rf "$HOME/.config/$folder"
  cp -r "$HOME/Teal-Memory/.config/$folder" "$HOME/.config/"
done

# === 5. Shell setup ===
echo "==> Setting zsh as default shell..."
chsh -s "$(which zsh)"

# === 6. Final message ===
echo ""
echo "✅ Teal-Memory setup complete!"
echo "You can now log out and select Hyprland to start."

