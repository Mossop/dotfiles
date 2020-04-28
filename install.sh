#! /bin/bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]:-$0}") && pwd | sed -e s/\\/$//g)

exec "$DOTFILES/install"
