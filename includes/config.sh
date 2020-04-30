export_config() {
  export DOTFILES_REPO
  export DOTFILES_BRANCH
}

if [ -f "$DOTFILES/external/.config" ]; then
  . "$DOTFILES/external/.config"
elif [ -d "$DOTFILES/.git" ]; then
  DOTFILES_REPO=$(git -C "$DOTFILES" remote get-url origin | sed -E -e s/\\.git$// -e s/^.*github.com.//)
  DOTFILES_BRANCH=$(git -C "$DOTFILES" rev-parse --abbrev-ref HEAD)
  . "$DOTFILES/scripts/write-config.sh"
else
  echo "Dotfiles is not correctly installed. No .config file exists."
  exit 1
fi
