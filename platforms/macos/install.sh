if command -v brew 1>/dev/null 2>&1; then
  brew upgrade
  brew install git joe gnu-which findutils gnu-sed gnu-tar grep coreutils wget curl
fi
