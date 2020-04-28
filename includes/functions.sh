install_files() {
  SOURCE="$1"
  TARGET="$2"

  if [ -d "$SOURCE" ]; then
    mkdir -p "$TARGET"
    tar -cp -C "$SOURCE" . | tar -xp -C "$TARGET"
  fi
}

maybe_source() {
  SCRIPT="$1"
  if [ -f "$SCRIPT" ]; then
    . "$SCRIPT"
  fi
}

add_path() {
  DIR="$1"
  if [ -d "$DIR" ]; then
    PATH="$DIR:$PATH"
  fi
}

request() {
  URL=$1
  if command -v curl 1>/dev/null 2>&1; then
    curl -sL "$URL"
  elif command -v wget 1>/dev/null 2>&1; then
    wget --quiet -O - "$URL"
  else
    echo "Neither wget nor curl are installed."
    exit 1
  fi
}

pull_hg_repo() {
  REPO="$1"
  TARGET="$2"

  if command -v hg 1>/dev/null 2>&1; then
    if [ -d "$TARGET" ]; then
      hg -q -R "$TARGET" pull -u
    else
      hg -q clone "$REPO" "$TARGET"
    fi
  fi
}

pull_git_repo() {
  REPO="$1"
  TARGET="$2"

  if command -v git 1>/dev/null 2>&1; then
    if [ -d "$TARGET" ]; then
      git -C "$TARGET" pull -q origin master
    else
      git clone -q "$REPO" "$TARGET"
    fi
  fi
}

if [[ ${OSTYPE:0:5} == "linux" ]]; then
  DOTFILES_PLATFORM="linux"
elif [[ ${OSTYPE:0:6} == "darwin" ]]; then
  DOTFILES_PLATFORM="macos"
else
  DOTFILES_PLATFORM="windows"
fi

PLATFORM_DIR="$DOTFILES/platforms/$DOTFILES_PLATFORM"
