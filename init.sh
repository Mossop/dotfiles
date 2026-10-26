#! /bin/sh

set -e

DOTSOURCE="Mossop/dotfiles"
export DOTFILES="$HOME/.dotfiles"

if ! command -v git 1>/dev/null 2>&1; then
  echo "Please install git"
  exit 1
fi

if ! command -v mise 1>/dev/null 2>&1; then
  if [ "$OS" == "Windows_NT" ]; then
    winget install jdx.mise
    export PATH="$HOME/AppData/Local/Microsoft/WinGet/Links:$PATH"
  else
    curl -fsSL https://mise.run | sh
    export PATH="$HOME/.local/bin/mise:$PATH"
  fi
fi

if [ ! -d "$DOTFILES" ]; then
  mkdir $DOTFILES
  git -C "$DOTFILES" init -b main -q
  git -C "$DOTFILES" remote add origin "https://github.com/$DOTSOURCE.git"
  git -C "$DOTFILES" remote set-url --push origin "git@github.com:$DOTSOURCE.git"
fi

export MISE_CONFIG_DIR="$DOTFILES/shared/mise"
export MISE_DOTFILES_ROOT="$DOTFILES/home"
exec mise run dotfiles:update
