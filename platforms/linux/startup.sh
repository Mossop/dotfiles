if [ -n "$VSCODE_GIT_EDITOR_NODE" ]; then
  add_path "$(dirname ${VSCODE_GIT_EDITOR_NODE})/bin/remote-cli"
fi
