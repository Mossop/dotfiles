if [ -n "$DOTFILES_SOURCED" ]; then
  return
fi

export DOTFILES_SOURCED=1
DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]:-$0}") && cd .. && pwd | sed -e s/\\/$//g)

. "$DOTFILES/includes/functions.sh"
. "$DOTFILES/includes/config.sh"

add_path "$HOME/bin"
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

export VIRTUAL_ENV_DISABLE_PROMPT=1

function virtualenv_info(){
  if [[ -n "$VIRTUAL_ENV" ]]; then
    # Strip out the path and just leave the env name
    echo -e " \\033[33m(${VIRTUAL_ENV##*/})\\033[0m"
  fi
}
typeset -fx virtualenv_info

VENV="\$(virtualenv_info)";

HOSTNAME=$(hostname | cut -d"." -f1 | tr '[:upper:]' '[:lower:]')
if [ "$DOTFILES_PLATFORM" == "windows" ]; then
  NAMEPROMPT="${HOSTNAME}"
else
  NAMEPROMPT="\\u@${HOSTNAME}"
fi

export PROMPT_START="\\[\\033]0;${NAMEPROMPT}\\007\\033[1;32m\\]${NAMEPROMPT}\\[\\033[0m\\]${VENV}"
export PROMPT_END="\\n\\[\\033[1;34m\\]\\W\\[\\033[0m\\]\\$ "

export PS1="${PROMPT_START}${PROMPT_END}"

if [ -d "$DOTFILES/external/pyenv" ]; then
  export PYENV_ROOT="$DOTFILES/external/pyenv"
  add_path "$PYENV_ROOT/bin"

  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

maybe_source "$PLATFORM_DIR/startup.sh"
