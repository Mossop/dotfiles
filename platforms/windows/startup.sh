if [ -d "/c/Users/Dave/AppData/Local/Programs/Microsoft VS Code" ]; then
  alias code=vscode
fi

if [ -x "/e/mozilla/bin/startup" ]; then
  alias mozb="/e/mozilla/bin/startup"
elif [ -x "/c/mozilla/bin/startup" ]; then
  alias mozb="/c/mozilla/bin/startup"
fi
