if command -v brew 1>/dev/null 2>&1; then
  PREFIX=$(brew --prefix)
  for PACKAGE in gnu-which findutils gnu-sed make gnu-tar grep coreutils
  do
    add_path "${PREFIX}/opt/${PACKAGE}/libexec/gnubin"
  done
  for PACKAGE in gnu-getopt util-linux
  do
    add_path "${PREFIX}/opt/${PACKAGE}/bin"
  done

  add_path "${PREFIX}/opt/curl/bin"
fi

add_path "/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/bin"
add_path "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

export BASH_SILENCE_DEPRECATION_WARNING=1

maybe_source "/opt/homebrew/etc/profile.d/bash_completion.sh"

if [ -d "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password" ]; then
  export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
fi
