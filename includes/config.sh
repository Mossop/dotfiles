export_config() {
  export DOTFILES_REPO
  export DOTFILES_BRANCH
}

write_config() {
  echo 'DOTFILES_REPO="${DOTFILES_REPO}"' > "$DOTFILES/.config"
  echo 'DOTFILES_BRANCH="${DOTFILES_BRANCH}"' >> "$DOTFILES/.config"
}

if [ -f "$DOTFILES/.config" ]; then
  . "$DOTFILES/.config"
else
  echo "Dotfiles is not correctly installed. No .config file exists."
  exit 1
fi
