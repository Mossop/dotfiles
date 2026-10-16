maybe_source() {
  if [ -r "$1" ]; then
    . "$1"
  fi
}

# Delete lines matching the sed pattern $2 from file $1. Avoids `sed -i`, which
# takes different arguments on BSD (macOS) and GNU sed.
strip() {
  if [ -f "$1" ]; then
    TMP_FILE=$(mktemp)
    sed "/$2/d" "$1" > "$TMP_FILE"
    cat "$TMP_FILE" > "$1"
    rm -f "$TMP_FILE"
  fi
}

append() {
  # Start on a fresh line if the file doesn't end with one.
  if [ -s "$1" ] && [ "$(tail -c 1 "$1")" != "" ]; then
    echo >> "$1"
  fi
  echo "$2" >> "$1"
}

prepend() {
  TMP_FILE=$(mktemp)
  echo "$2" > "$TMP_FILE"
  if [ -f "$1" ]; then
    cat "$1" >> "$TMP_FILE"
  fi

  cat "$TMP_FILE" > "$1"
  rm -f "$TMP_FILE"
}
