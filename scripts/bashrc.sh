if [ -n "$DOTFILES_BASHRC_SOURCED" ]; then
  return
fi

export DOTFILES_BASHRC_SOURCED=1

. $(dirname "${BASH_SOURCE[0]:-$0}")/startup.sh
