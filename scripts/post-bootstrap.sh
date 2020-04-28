#! /bin/bash

set -e

. "$DOTFILES/scripts/write-config.sh"

exec "$DOTFILES/install"
