install_files() {
  local SOURCE="$1"
  local TARGET="$2"

  if [ -d "$SOURCE" ]; then
    mkdir -p "$TARGET"
    tar -cp -C "$SOURCE" . | tar -xp -C "$TARGET"
  fi
}

maybe_source() {
  local SCRIPT="$1"

  if [ -r "$SCRIPT" ]; then
    . "$SCRIPT"
  fi
}

add_path() {
  local dir="$1"

  if [ -d "$dir" ]; then
    PATH="$dir:$PATH"
  fi
}

clean_path() {
  PATH=$(echo $PATH | tr ':' '\n' | awk '!seen[$0]++' - | tr '\n' ':' | sed -e s/.$//)
}

link_directory() {
  local directory="$1"
  local link="$2"

  if [ -e "$directory" -a ! -d "$directory" ]; then
    echo "$directory is not a directory."
    exit 1
  fi

  if [ -h "$link" ]; then
    target=$(readlink "$link")
    if [ "$target" != "$directory" ]; then
      rm "$link"
    else
      mkdir -p "$directory"
      return
    fi
  elif [ -d "$link" -a ! -e "$directory" ]; then
    mv "$link" "$directory"
  elif [ -e "$link" ]; then
    echo "Something already exists at $link."
    exit 1
  fi

  mkdir -p "$directory"
  ln -s "$directory" "$link"
}

request() {
  local URL=$1

  if command -v curl 1>/dev/null 2>&1; then
    curl -sL "$URL"
  elif command -v wget 1>/dev/null 2>&1; then
    wget --quiet -O - "$URL"
  else
    echo "Neither wget nor curl are installed."
    exit 1
  fi
}

update_hg_repo() {
  local TARGET="$1"

  if command -v hg 1>/dev/null 2>&1; then
    if [ -d "$TARGET" ]; then
      hg -q -R "$TARGET" pull -u
    fi
  fi
}

pull_hg_repo() {
  local REPO="$1"
  local TARGET="$2"

  if command -v hg 1>/dev/null 2>&1; then
    if [ -d "$TARGET" ]; then
      hg -q -R "$TARGET" pull -u
    else
      hg -q clone "$REPO" "$TARGET"
    fi
  fi
}

update_git_repo() {
  local TARGET="$1"

  if command -v git 1>/dev/null 2>&1; then
    if [ -d "$TARGET" ]; then
      git -C "$TARGET" pull -q origin master
    fi
  fi
}

pull_git_repo() {
  local REPO="$1"
  local TARGET="$2"

  if command -v git 1>/dev/null 2>&1; then
    if [ -d "$TARGET" ]; then
      git -C "$TARGET" pull -q origin master
    else
      git clone -q "$REPO" "$TARGET"
    fi
  fi
}

clean_up() {
  unset install_files
  unset maybe_source
  unset add_path
  unset request
  unset update_hg_repo
  unset pull_hg_repo
  unset update_git_repo
  unset pull_git_repo
  unset export_config
  unset clean_path
  unset clean_up
}

if [[ ${OSTYPE:0:5} == "linux" ]]; then
  DOTFILES_PLATFORM="linux"
  DIR_SEP="/"
  BIN_EXT=""
elif [[ ${OSTYPE:0:6} == "darwin" ]]; then
  DOTFILES_PLATFORM="macos"
  DIR_SEP="/"
  BIN_EXT=""
else
  DOTFILES_PLATFORM="windows"
  DIR_SEP="\\"
  BIN_EXT=".exe"
fi

PLATFORM_DIR="$DOTFILES/platforms/$DOTFILES_PLATFORM"
