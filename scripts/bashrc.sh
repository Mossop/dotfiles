if [ -n "$DOTFILES_BASHRC_SOURCED" ]; then
  return
fi

export DOTFILES_BASHRC_SOURCED=1

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]:-$0}") && cd .. && pwd | sed -e s/\\/$//g)

. "$DOTFILES/includes/functions.sh"
. "$DOTFILES/includes/config.sh"

add_path "$HOME/bin"
add_path "$DOTFILES/bin"
add_path "$PLATFORM_DIR/bin"

if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

maybe_source "$PLATFORM_DIR/bashrc.sh"

clean_up
