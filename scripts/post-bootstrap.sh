#! /bin/bash

set -e

mkdir -p "$DOTFILES/external"
. "$DOTFILES/scripts/write-config.sh"

exec "$DOTFILES/install"
