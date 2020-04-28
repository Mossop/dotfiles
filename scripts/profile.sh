if [ -n "$DOTFILES_SOURCED" ]; then
  return
fi

if [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi
