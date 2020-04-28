#! /bin/bash

set -e

. "$DOTFILES/includes/config.sh"

write_config

exec "$DOTFILES/install"
