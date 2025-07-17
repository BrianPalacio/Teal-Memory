#!/bin/bash

set -e

echo "==> Starting Teal-Memory setup..."

# === 1. Check for Wayland support ===
if [ "$XDG_SESSION_TYPE" != "wayland" ]; then
  echo "⚠️  Warning: You are not in a Wayland session. Hyprland requires Wayland to run."
fi

# === 2. Required packages ===
echo "==> Installing core packages..."

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
  swww
  waypaper
)

sudo pacman -Syu --needed --noconfirm "${PKGS[@]}"

# === 3. Fonts ===
echo "==> Installing fonts..."
sudo pacman -S --needed --noconfirm ttf-jetbrains-mono ttf-font-awesome noto-fonts noto-fonts-emoji

# === 4. yay (AUR helper) ===
if ! command -v yay &> /dev/null; then
  echo "==> Installing yay AUR helper..."
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay
  makepkg -si --noconfirm
  cd ~
fi

# === 5. Copy config folders ===
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

# === 6. Copy .ml4w hidden folders ===
echo "==> Copying .ml4w folders..."

for hidden_dir in .ml4w .ml4w-hyprland; do
  if [ -d "$HOME/Teal-Memory/$hidden_dir" ]; then
    echo "  -> $hidden_dir"
    rm -rf "$HOME/$hidden_dir"
    cp -r "$HOME/Teal-Memory/$hidden_dir" "$HOME/"
  fi
done

# === 7. Copy wallpapers if available ===
if [ -d "$HOME/Teal-Memory/wallpapers" ]; then
  echo "==> Copying wallpapers..."
  mkdir -p "$HOME/Pictures/wallpapers"
  cp -r "$HOME/Teal-Memory/wallpapers/"* "$HOME/Pictures/wallpapers/"
fi

# === 8. Set zsh as default shell ===
echo "==> Setting zsh as default shell..."
chsh -s "$(which zsh)"

# === 9. Final message ===
echo ""
echo "✅ Teal-Memory setup complete!"
echo "📦 Packages installed, configs copied, Wayland tools ready."
echo "🚀 Log out and select Hyprland from the login screen to begin."

