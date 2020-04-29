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

  if [ -f "$SCRIPT" ]; then
    . "$SCRIPT"
  fi
}

add_path() {
  local DIR="$1"

  if [ -d "$DIR" ]; then
    local _IFS=$IFS
    IFS=":"

    for p in $PATH
    do
      if [ "$p" = "$DIR" ]; then
        IFS=$_IFS
        return
      fi
    done

    PATH="$DIR:$PATH"
    IFS=$_IFS
  fi
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
  unset clean_up
}

if [[ ${OSTYPE:0:5} == "linux" ]]; then
  DOTFILES_PLATFORM="linux"
elif [[ ${OSTYPE:0:6} == "darwin" ]]; then
  DOTFILES_PLATFORM="macos"
else
  DOTFILES_PLATFORM="windows"
fi

PLATFORM_DIR="$DOTFILES/platforms/$DOTFILES_PLATFORM"
