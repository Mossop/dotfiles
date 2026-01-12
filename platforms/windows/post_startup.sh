if [ -z "$__MISE_SESSION" ]; then
  if command -v direnv 1>/dev/null 2>&1; then
    export _unmangle_direnv_names="PATH"
    _unmangle_direnv_paths() {
      for k in $_unmangle_direnv_names; do
        eval "$k=\"\$(/usr/bin/cygpath -p \"\$$k\")\""
      done
    }
    eval "$(direnv hook bash | sed -e 's@export bash)@export bash)\
      _unmangle_direnv_paths@')"
  fi
fi
