export_config() {
  export DOTFILES_REPO
  export DOTFILES_BRANCH
}

if [ -f "$DOTFILES/.config" ]; then
  . "$DOTFILES/.config"
else
  echo "Dotfiles is not correctly installed. No .config file exists."
  exit 1
fi
