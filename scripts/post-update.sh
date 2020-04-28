#! /bin/bash

set -e

. "$DOTFILES/includes/config.sh"

write_config

rm -f "$TMPFILE"
exec "$DOTFILES/install"
