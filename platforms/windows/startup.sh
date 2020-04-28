if [ -d "/c/Users/Dave/AppData/Local/Programs/Microsoft VS Code" ]; then
  export EDITOR="code -w"
  export VISUAL="code -w"
fi

if [ -x "/c/mozilla/bin/startup" ]; then
  alias mozb="/c/mozilla/bin/startup"
fi
