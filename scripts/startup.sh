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

export PROMPT_START="\\[\\033]0;${NAMEPROMPT}\\007\\033[1;32m\\]${NAMEPROMPT}\\[\\033[0m\\]"
export PROMPT_END="\\n\\[\\033[1;34m\\]\\W\\[\\033[0m\\]\\$ "

export PS1="${PROMPT_START}${PROMPT_END}"

export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=1
. "$DOTFILES/platforms/macos/iterm2_shell_integration.bash"

maybe_source "$PLATFORM_DIR/startup.sh"

if command -v code-insiders 1>/dev/null 2>&1; then
  alias code=code-insiders
  export EDITOR="code-insiders -w"
  export VISUAL="code-insiders -w"
elif command -v code 1>/dev/null 2>&1; then
  export EDITOR="code -w"
  export VISUAL="code -w"
elif command -v joe 1>/dev/null 2>&1; then
  export EDITOR=joe
  export VISUAL=joe
fi

clean_path
clean_up
