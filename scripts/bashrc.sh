if [ -z "$DOTFILES_SOURCED" ]; then
  DOTFILES_BASHRC_SOURCED=1
  . $(dirname "${BASH_SOURCE[0]:-$0}")/startup.sh
fi
