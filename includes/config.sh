export_config() {
  export DOTFILES_REPO
  export DOTFILES_BRANCH
}

load_config() {
  if [ -f "$DOTFILES/external/.config" ]; then
    . "$DOTFILES/external/.config"
  else
    echo "Dotfiles is not correctly installed. No .config file exists."
    exit 1
  fi
}
