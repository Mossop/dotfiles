if [ -d "/c/Users/Dave/AppData/Local/Programs/Microsoft VS Code" ]; then
  alias code=vscode
fi

if [ -f "$HOME/bin/direnv.exe" ]; then
  export _unmangle_direnv_names="PATH"
  _unmangle_direnv_paths() {
      for k in $_unmangle_direnv_names; do
          eval "$k=\"\$(/usr/bin/cygpath -p \"\$$k\")\""
      done
  }
  eval "$(direnv hook bash | sed -e 's@export bash)@export bash)\
    _unmangle_direnv_paths@')"
fi
