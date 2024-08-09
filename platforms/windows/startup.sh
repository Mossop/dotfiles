if [ -d "/c/Users/Dave/AppData/Local/Programs/Microsoft VS Code" ]; then
  alias code=vscode
fi

if [ -f "/e/mozilla/bin/activate" ]; then
  alias mozb=". /e/mozilla/bin/activate"
elif [ -f "/c/mozilla/bin/activate" ]; then
  alias mozb=". /c/mozilla/bin/activate"
fi
