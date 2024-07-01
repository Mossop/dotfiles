if [ -x "$HOME/mozilla/bin/startup" ]; then
  alias mozb="$HOME/mozilla/bin/startup"
fi

if [ -f "$HOME/.local/bin/mise" ]; then
  eval "$HOME/.local/bin/mise activate bash)"
fi
