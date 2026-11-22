#!/usr/bin/env bash
#
# setup-zsh.sh
#   Sets up zsh, Oh My Zsh, Powerlevel10k and the plugins
#   (git, zsh-autosuggestions, zsh-syntax-highlighting, command-not-found)
#   for apt-based distros (Debian / Ubuntu / Parrot OS).
#
# Usage:
#   bash setup-zsh.sh
#
set -euo pipefail

info() { printf '\033[1;34m[INFO]\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[WARN]\033[0m %s\n' "$*"; }
err()  { printf '\033[1;31m[ERR ]\033[0m %s\n' "$*" >&2; }

# ---------------------------------------------------------------------------
# Prompt helper: ask_yn "question" <default y|n>
#   y/yes -> return 0, n/no -> return 1. Empty input selects the default.
#   If stdin is not a terminal, the default is used.
# ---------------------------------------------------------------------------
ask_yn() {
  local prompt="$1" default="$2" ans
  if [[ ! -t 0 ]]; then
    [[ "$default" == "y" ]]
    return
  fi
  while true; do
    read -r -p "$prompt" ans || ans=""
    ans="${ans:-$default}"
    case "${ans,,}" in
      y|yes) return 0 ;;
      n|no)  return 1 ;;
      *)     echo "Please answer y or n." ;;
    esac
  done
}

backup_file() {
  local f="$1"
  if [[ -e "$f" ]]; then
    local bak="${f}.bak.$(date +%Y%m%d-%H%M%S)"
    cp -a "$f" "$bak"
    info "Backup: $f -> $bak"
  fi
}

clone_or_update() {
  local url="$1" dest="$2"
  if [[ -d "$dest/.git" ]]; then
    info "Updating: $dest"
    git -C "$dest" pull --ff-only --quiet || warn "Update failed (skipped): $dest"
  else
    info "Cloning: $url -> $dest"
    git clone --depth=1 "$url" "$dest"
  fi
}

# ---------------------------------------------------------------------------
# Pre-flight checks
# ---------------------------------------------------------------------------
if ! command -v apt-get >/dev/null 2>&1; then
  err "apt-get not found. This script targets apt-based distributions."
  exit 1
fi

SUDO=""
if [[ $EUID -ne 0 ]]; then
  if command -v sudo >/dev/null 2>&1; then
    SUDO="sudo"
  else
    err "Neither root nor sudo is available."
    exit 1
  fi
fi

# ---------------------------------------------------------------------------
# Questions (asked up front so the rest runs unattended)
# ---------------------------------------------------------------------------
echo
echo "# If you come from bash you might have to change your \$PATH."
echo "# export PATH=\$HOME/bin:\$HOME/.local/bin:/usr/local/bin:\$PATH"
if ask_yn "Enable the PATH setting above in ~/.zshrc? [y|n]: " "n"; then
  ENABLE_PATH=1
else
  ENABLE_PATH=0
fi

echo

# ---------------------------------------------------------------------------
# 1. Install packages (zsh, git, curl, command-not-found)
# ---------------------------------------------------------------------------
info "Installing apt packages (zsh git curl command-not-found)"
$SUDO apt-get update -y
$SUDO apt-get install -y zsh git curl ca-certificates command-not-found

# ---------------------------------------------------------------------------
# 2. Oh My Zsh
# ---------------------------------------------------------------------------
export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
if [[ -d "$ZSH" ]]; then
  info "Oh My Zsh is already installed: $ZSH"
else
  info "Installing Oh My Zsh"
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi
ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH/custom}"

# ---------------------------------------------------------------------------
# 3. Powerlevel10k and plugins
# ---------------------------------------------------------------------------
P10K_DIR="$ZSH_CUSTOM/themes/powerlevel10k"
clone_or_update https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
clone_or_update https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_or_update https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
# git and command-not-found are bundled with Oh My Zsh; nothing extra to install

# ---------------------------------------------------------------------------
# 4. Set the theme and plugins in ~/.zshrc (created by the Oh My Zsh installer)
# ---------------------------------------------------------------------------
ZSHRC="$HOME/.zshrc"
if [[ ! -f "$ZSHRC" ]]; then
  cp "$ZSH/templates/zshrc.zsh-template" "$ZSHRC"
  info "Created $ZSHRC from the Oh My Zsh template"
fi
backup_file "$ZSHRC"
if grep -q '^ZSH_THEME=' "$ZSHRC"; then
  sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' "$ZSHRC"
  info "Set ZSH_THEME=\"powerlevel10k/powerlevel10k\" in $ZSHRC"
else
  err "ZSH_THEME line not found in $ZSHRC; please set it manually."
  exit 1
fi

# Enable the plugins
PLUGINS_LINE='plugins=(git zsh-autosuggestions zsh-syntax-highlighting command-not-found)'
if grep -q '^plugins=(' "$ZSHRC"; then
  sed -i "s|^plugins=(.*|${PLUGINS_LINE}|" "$ZSHRC"
  info "Set ${PLUGINS_LINE}"
else
  err "plugins line not found in $ZSHRC; please set it manually."
  exit 1
fi

# Enable the PATH setting
if [[ $ENABLE_PATH -eq 1 ]]; then
  ln="$(grep -n '^# export PATH=\$HOME/bin' "$ZSHRC" | head -n1 | cut -d: -f1)"
  if [[ -n "$ln" ]]; then
    sed -i "${ln}s/^# //" "$ZSHRC"
    info "PATH setting enabled (~/.zshrc:${ln})"
  else
    warn "PATH line not found"
  fi
else
  info "Leaving the PATH setting commented out"
fi

# ---------------------------------------------------------------------------
# 5. Powerlevel10k initial configuration
# ---------------------------------------------------------------------------
P10K_CONF="$HOME/.p10k.zsh"
# With no ~/.p10k.zsh, the wizard starts automatically on the first zsh launch
if [[ -e "$P10K_CONF" ]]; then
  backup_file "$P10K_CONF"
  rm -f "$P10K_CONF"
fi
info "Run the p10k wizard on first zsh launch (or later with 'p10k configure')"

# ---------------------------------------------------------------------------
# Done
# ---------------------------------------------------------------------------
echo
info "Setup complete."
echo "  - Try zsh now:             exec zsh"
echo "  - Make zsh login shell:    chsh -s \"\$(command -v zsh)\""
echo "  - For icons, set a Nerd Font (recommended: MesloLGS NF) in your terminal"