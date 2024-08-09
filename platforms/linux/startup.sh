if [ -f "$HOME/mozilla/bin/activate" ]; then
  alias mozb=". $HOME/mozilla/bin/activate"
fi

if [ -f "$HOME/.local/bin/mise" ]; then
  eval "$($HOME/.local/bin/mise activate bash)"
fi
