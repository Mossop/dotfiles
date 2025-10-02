#! /bin/bash

set -e

. "$DOTFILES/includes/config.sh"
. "$DOTFILES/includes/functions.sh"

cd $DOTFILES/home && find . -type f -print0 | $(cd $HOME && xargs -0 rm)
cd $PLATFORM_DIR/home && find . -type f -print0 | $(cd $HOME && xargs -0 rm)
cd $DOTFILES

if [ -d "$DOTFILES/.git" ]; then
  if [ -f "$HOME/.ssh/id_rsa_github" ]; then
    git -C "$DOTFILES" remote set-url origin "git@github.com:${DOTFILES_REPO}.git"
  elif [ -n "$SSH_AUTH_SOCK" ]; then
    if ssh-add -l | grep -q id_rsa_github 1>/dev/null 2>&1; then
      git -C "$DOTFILES" remote set-url origin "git@github.com:${DOTFILES_REPO}.git"
    fi
  fi
  git -C "$DOTFILES" pull -q origin $DOTFILES_BRANCH
elif command -v git 1>/dev/null 2>&1; then
  if [ -f "$HOME/.ssh/id_rsa_github" ]; then
    git clone -q --bare -b $DOTFILES_BRANCH "git@github.com:${DOTFILES_REPO}.git" "$DOTFILES/.git"
  else
    git clone -q --bare -b $DOTFILES_BRANCH "https://github.com/${DOTFILES_REPO}.git" "$DOTFILES/.git"
  fi
  sed -i.bak "/bare =/d" "$DOTFILES/.git/config"
  rm -f "$DOTFILES/.git/config.bak"
  git -C "$DOTFILES" checkout -q -f $DOTFILES_BRANCH
  git -C "$DOTFILES" reset -q --hard $DOTFILES_BRANCH
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
    curl -sL "https://github.com/${DOTFILES_REPO}/archive/$DOTFILES_BRANCH.tar.gz" | tar -xpz -C "$tmpdir" --strip-components=1
  elif command -v wget 1>/dev/null 2>&1; then
    wget --quiet -O - "https://github.com/${DOTFILES_REPO}/archive/$DOTFILES_BRANCH.tar.gz" | tar -xpz -C "$tmpdir" --strip-components=1
  else
    echo "Neither curl nor wget are available, cannot proceed."
    exit 1
  fi

  for f in $(cd "$DOTFILES" && ls -A)
  do
    if [ "$f" != "external" ]; then
      rm -rf "$DOTFILES/$f"
    fi
  done

  tar -cp -C "$tmpdir" . | tar -xp -C "$DOTFILES"
  rm -rf "$tmpdir"
fi

export_config
exec "$DOTFILES/scripts/post-update.sh"
