if [ -f "$HOME/mozilla/bin/activate" ]; then
  export MOZBUILD="$HOME/mozilla/bin/activate"
fi

if [ -f "$HOME/.local/bin/mise" ]; then
  eval "$($HOME/.local/bin/mise activate bash)"
fi
