if [ -f "$HOME/mozilla/bin/activate" ]; then
  export MOZBUILD="$HOME/mozilla/bin/activate"
fi

if [ -f "$HOME/.local/bin/mise" ]; then
  eval "$($HOME/.local/bin/mise activate bash)"
fi

if [ -x "/usr/local/bin/starship" ]; then
  export STARSHIP_CONFIG=$DOTFILES/shared/starship.toml
  eval "$(/usr/local/bin/starship init bash)"
fi
