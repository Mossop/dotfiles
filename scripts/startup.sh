if [ -z "$DOTFILES_BASHRC_SOURCED" ]; then
  . $(dirname "${BASH_SOURCE[0]:-$0}")/bashrc.sh
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

HOSTNAME=$(hostname | cut -d"." -f1 | tr '[:upper:]' '[:lower:]')
if [ "$DOTFILES_PLATFORM" == "windows" ]; then
  NAMEPROMPT="${HOSTNAME}"
else
  NAMEPROMPT="\\u@${HOSTNAME}"
fi

export PROMPT_START="\\[\e]0;${NAMEPROMPT}\\007\e[1;32m\\]${NAMEPROMPT}\\[\e[0m\\]"
export PROMPT_END="\\n\$(__git_ps1 \"\e[33m[%s]\e[0m \")\\[\e[1;34m\\]\\W\\[\e[0m\\]\\$ "

export PS1="${PROMPT_START}${PROMPT_END}"

maybe_source "$PLATFORM_DIR/startup.sh"

if command -v code 1>/dev/null 2>&1; then
  export VSCODE="code"
  export EDITOR="code -w"
  export VISUAL="code -w"
elif [ ! -z "$VSCODE_GIT_EDITOR_NODE" ]; then
  export VSCODE=$(echo $VSCODE_GIT_EDITOR_NODE | sed -e s~\\${DIR_SEP}~/~g | sed -e s~/node${BIN_EXT}\$~/bin/remote-cli/code${BIN_EXT}~ | sed -e s~/code${BIN_EXT}\$~/code.cmd~ | sed -e s~^C:~/c~)
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

clean_path
clean_up

if [ ! -z "$MOZBUILD" ]; then
  alias mozb=". $MOZBUILD"

  if [ ! -z "$ACTIVATE_MOZBUILD" ]; then
    unset ACTIVATE_MOZBUILD
    . $MOZBUILD
  fi
fi
