#! /bin/bash

set -e

. "$DOTFILES/scripts/write-config.sh"

rm -f "$TMPFILE"
exec "$DOTFILES/install"
