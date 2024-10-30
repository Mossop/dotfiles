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

maybe_source "/opt/homebrew/etc/profile.d/bash_completion.sh"

if [ -d "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password" ]; then
  export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
fi
