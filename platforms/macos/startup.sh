if command -v brew 1>/dev/null 2>&1; then
  PREFIX=$(brew --prefix)
  for PACKAGE in gnu-which findutils gnu-sed gnu-tar grep coreutils
  do
    add_path "${PREFIX}/opt/${PACKAGE}/libexec/gnubin"
  done
fi

if [ -d "/Applications/Visual Studio Code - Insiders.app" ]; then
  add_path "/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/bin"
  export EDITOR="code -w"
  export VISUAL="code -w"
elif [ -d "/Applications/Visual Studio Code.app" ]; then
  add_path "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
  export EDITOR="code -w"
  export VISUAL="code -w"
else
  export EDITOR=joe
  export VISUAL=joe
fi

if [ -x "$HOME/mozilla/bin/startup" ]; then
  alias mozb="$HOME/mozilla/bin/startup"
fi

export BASH_SILENCE_DEPRECATION_WARNING=1