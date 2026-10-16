maybe_source() {
  if [ -r "$1" ]; then
    . "$1"
  fi
}

strip() {
  if [ -f "$1" ]; then
    sed -i "/$2/d" "$1"
  fi
}

append() {
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
