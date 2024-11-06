export PATH=$(echo $PATH | sed -e s~/Git/cmd~/Git/mingw64/bin~g)

if [ -f "/c/mozilla-build/msys2/usr/bin/ssh.exe" ]; then
  export GIT_SSH="C:\\mozilla-build\\msys2\\usr\\bin\\ssh.exe"
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

# Broken on windows for now.
VSCODE_SHELL_INTEGRATION=1
