if [ -d "/c/Users/Dave/AppData/Local/Programs/Microsoft VS Code" ]; then
  alias code=vscode
fi

if [ -f "/e/mozilla/bin/activate" ]; then
  export MOZBUILD="/e/mozilla/bin/activate"
elif [ -f "/c/mozilla/bin/activate" ]; then
  export MOZBUILD="/c/mozilla/bin/activate"
fi
