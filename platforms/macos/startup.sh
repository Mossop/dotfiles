if command -v brew 1>/dev/null 2>&1; then
  PREFIX=$(brew --prefix)
  for PACKAGE in gnu-which findutils gnu-sed gnu-tar grep coreutils
  do
    add_path "${PREFIX}/opt/${PACKAGE}/libexec/gnubin"
  done

  add_path "${PREFIX}/opt/curl/bin"
fi

if [ -d "/Applications/Visual Studio Code - Insiders.app" ]; then
  add_path "/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/bin"
elif [ -d "/Applications/Visual Studio Code.app" ]; then
  add_path "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi

export BASH_SILENCE_DEPRECATION_WARNING=1

if [ -f "/opt/homebrew/bin/mise" ]; then
  eval "$(/opt/homebrew/bin/mise activate bash)"
fi

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

if [ -x "/opt/homebrew/bin/starship" ]; then
  export STARSHIP_CONFIG=$DOTFILES/shared/starship.toml
  eval "$(/opt/homebrew/bin/starship init bash)"
fi
