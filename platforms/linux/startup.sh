if command -v joe 1>/dev/null 2>&1; then
  export EDITOR=joe
  export VISUAL=joe
fi

if [ -x "$HOME/mozilla/bin/startup" ]; then
  alias mozb="$HOME/mozilla/bin/startup"
fi
