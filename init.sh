#! /bin/sh

set -e

DOTSOURCE="Mossop/dotfiles"
export DOTFILES="$HOME/.dotfiles"

if ! command -v git 1>/dev/null 2>&1; then
  echo "Please install git"
  exit 1
fi

export MISE_SELF_UPDATE_MINIMUM_RELEASE_AGE="1h"

if ! command -v mise 1>/dev/null 2>&1; then
  if [ "$OS" == "Windows_NT" ]; then
    powershell.exe -NoProfile -Command "irm https://mise.run/powershell | iex"
  else
    curl -fsSL https://mise.run | sh
  fi
  export MISE="$HOME/.local/bin/mise"
else
  export MISE="$(which mise)"
fi

if [ ! -d "$DOTFILES" ]; then
  git clone -q https://github.com/$DOTSOURCE.git "$DOTFILES"
  git -C "$DOTFILES" remote set-url --push origin "git@github.com:$DOTSOURCE.git"
fi

export MISE_CONFIG_DIR="$DOTFILES/shared/mise"
export MISE_DOTFILES_ROOT="$DOTFILES/home"
exec "$MISE" --cd $HOME run dotfiles:update
