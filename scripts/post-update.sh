#! /bin/bash

set -e

mkdir -p "$DOTFILES/external"
. "$DOTFILES/scripts/write-config.sh"

rm -f "$TMPFILE"
exec "$DOTFILES/install"

mise self-update
mise upgrade
