if command -v brew 1>/dev/null 2>&1; then
  brew upgrade --quiet
  brew install --quiet git joe gnu-which findutils gnu-sed gnu-tar grep coreutils wget curl starship mise
fi
