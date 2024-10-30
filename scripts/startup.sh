if [ -n "$DOTFILES_SOURCED" ]; then
  return
fi

DOTFILES_SOURCED=1

if [ -z "$DOTFILES_BASHRC_SOURCED" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]:-$0}") && cd .. && pwd | sed -e s/\\/$//g)

. "$DOTFILES/includes/functions.sh"
. "$DOTFILES/includes/config.sh"

add_path "$HOME/bin"
add_path "$HOME/.local/bin"
add_path "$DOTFILES/bin"
add_path "$PLATFORM_DIR/bin"

if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

if command -v dircolors 1>/dev/null 2>&1; then
  eval $(dircolors "$DOTFILES/shared/dircolors")
fi
alias ls="ls --color"

export LESS="FRSX"
unset HISTFILE
unset MAILCHECK

maybe_source "$PLATFORM_DIR/startup.sh"

if command -v code 1>/dev/null 2>&1; then
  export VSCODE="code"
  export EDITOR="code -w"
  export VISUAL="code -w"
elif [ ! -z "$VSCODE_GIT_EDITOR_NODE" ]; then
  export VSCODE=$(echo $VSCODE_GIT_EDITOR_NODE | sed -e s~\\${DIR_SEP}~/~g | sed -e s~/node${BIN_EXT}\$~/bin/remote-cli/code${BIN_EXT}~ | sed -e s~/code.exe\$~/code.cmd~ | sed -e s~^C:~/c~)
  alias code=$VSCODE
  export EDITOR="$VSCODE -w"
  export VISUAL="$VSCODE -w"
elif command -v joe 1>/dev/null 2>&1; then
  export EDITOR=joe
  export VISUAL=joe
fi

if [ "$TERM_PROGRAM" == "vscode" ]; then
  if [ -z "$VSCODE_SHELL_INTEGRATION" ]; then
    . "$(code --locate-shell-integration-path bash)"
  fi
else
  export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=1
  . "$DOTFILES/platforms/macos/iterm2_shell_integration.bash"
fi

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
fi

clean_path
clean_up
