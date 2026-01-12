export PATH=$(echo $PATH | sed -e s~/Git/cmd~/Git/mingw64/bin~g)

if [ -f "/c/mozilla-build/msys2/usr/bin/ssh.exe" ]; then
  export GIT_SSH="C:\\mozilla-build\\msys2\\usr\\bin\\ssh.exe"
fi

# Broken on windows for now.
VSCODE_SHELL_INTEGRATION=1
