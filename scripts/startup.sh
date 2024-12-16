if [ -n "$DOTFILES_SOURCED" ]; then
  return
fi

DOTFILES_SOURCED=1

if [ -n "$PS1" -a -f "$HOME/.local/share/blesh/ble.sh" ]; then
  [[ $- == *i* ]] && source "$HOME/.local/share/blesh/ble.sh" --noattach
fi

if [ -z "$DOTFILES_BASHRC_SOURCED" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]:-$0}") && cd .. && pwd | sed -e s/\\/$//g)

. "$DOTFILES/includes/functions.sh"
. "$DOTFILES/includes/config.sh"

if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

if command -v dircolors 1>/dev/null 2>&1; then
  eval $(dircolors "$DOTFILES/shared/dircolors")
fi
alias ls="ls --color"

export LESS="FRSX"
unset MAILCHECK

export JJ_CONFIG="$DOTFILES/shared/jj/config.toml"

maybe_source "$PLATFORM_DIR/startup.sh"

add_path "$DOTFILES/bin"
add_path "$PLATFORM_DIR/bin"
add_path "$HOME/.local/bin"
add_path "$HOME/bin"

if command -v code 1>/dev/null 2>&1; then
  export VSCODE="code"
  export EDITOR="code -w"
elif command -v code.cmd 1>/dev/null 2>&1; then
  export VSCODE="code.cmd"
  alias code=$VSCODE
  export EDITOR="$VSCODE -w"
elif command -v joe 1>/dev/null 2>&1; then
  export EDITOR=joe
fi

export VISUAL="$EDITOR"

if command -v mise 1>/dev/null 2>&1; then
  if [ -z "$PS1" ]; then
    eval "$(mise activate bash --shims)"
  else
    eval "$(mise activate bash)"
  fi
fi

if [ -n "$PS1" ]; then
  if command -v starship 1>/dev/null 2>&1; then
    export STARSHIP_CONFIG=$DOTFILES/shared/starship.toml
    eval "$(starship init bash)"
  fi

  if [ "$TERM_PROGRAM" == "vscode" ]; then
    if [ -z "$VSCODE_SHELL_INTEGRATION" ]; then
      . "$($VSCODE --locate-shell-integration-path bash)"
    fi
  else
    export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=1
    . "$DOTFILES/platforms/macos/iterm2_shell_integration.bash"
  fi

  if command -v atuin 1>/dev/null 2>&1; then
    eval "$(atuin init bash)"
  fi

  if [ -f "$HOME/.local/share/blesh/ble.sh" ]; then
    [[ ! ${BLE_VERSION-} ]] || ble-attach
  fi
fi

clean_path
clean_up
