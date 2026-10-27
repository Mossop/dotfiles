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
    winget install jdx.mise
    export MISE="$HOME/AppData/Local/Microsoft/WinGet/Links/mise"
  else
    curl -fsSL https://mise.run | sh
    export MISE="$HOME/.local/bin/mise"
  fi
else
  export MISE="$(which mise)"
  mise self-update -y
fi

if [ ! -d "$DOTFILES" ]; then
  git clone -q https://github.com/$DOTSOURCE.git "$DOTFILES"
  git -C "$DOTFILES" remote set-url --push origin "git@github.com:$DOTSOURCE.git"
fi

export MISE_CONFIG_DIR="$DOTFILES/shared/mise"
export MISE_DOTFILES_ROOT="$DOTFILES/home"
exec "$MISE" run dotfiles:update
