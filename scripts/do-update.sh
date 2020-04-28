#! /bin/bash

set -e

. "$DOTFILES/includes/config.sh"

if [ -d "$DOTFILES/.git" ]; then
  git -C "$DOTFILES" pull origin $DOTFILES_BRANCH
else
  if ! command -v tar 1>/dev/null 2>&1; then
    echo "tar is not installed, cannot proceed."
    exit 1
  fi

  if command -v mktemp 1>/dev/null 2>&1; then
    tmpdir=$(mktemp -d)
  elif [ -n "$TMPDIR" ]; then
    tmpdir="$TMPDIR/dotfiles-update-dir"
  elif [ -n "$TEMP" ]; then
    tmpdir="$TEMP/dotfiles-update-dir"
  elif [ -n "$TMP" ]; then
    tmpdir="$TMP/dotfiles-update-dir"
  else
    echo "Could not find a temporary directory."
    exit 1
  fi

  mkdir -p "$tmpdir"

  if command -v curl 1>/dev/null 2>&1; then
    curl -sL "https://github.com/${REPO}/archive/$DOTFILES_BRANCH.tar.gz" | tar -xpz -C "$tmpdir" --strip-components=1
  elif command -v wget 1>/dev/null 2>&1; then
    wget --quiet -O - "https://github.com/${REPO}/archive/$DOTFILES_BRANCH.tar.gz" | tar -xpz -C "$tmpdir" --strip-components=1
  else
    echo "Neither curl nor wget are available, cannot proceed."
    exit 1
  fi

  for f in $(cd "$DOTFILES" && ls -A)
  do
    if [ "$f" -ne ".config" ]; then
      echo rm -rf "$DOTFILES/$f"
    fi
  done

  tar -cp -C $(dirname "$tmpdir") $(basename "$tmpdir") | tar -xp -C "$DOTFILES" --strip-components=1
  rm -rf "$tmpdir"
fi

export_config
exec "$DOTFILES/scripts/post-update.sh"
