#! /bin/bash

# Sourced from bashrc/bash_profile before startup.sh. Runs `chezmoi update` at
# most once a week, then sources startup.sh so a fresh update takes effect.

SOURCE_DIR="$1"
STARTUP="$2"
LAST_UPDATE_FILE="$SOURCE_DIR/.last_update"
UPDATE_INTERVAL=$((7 * 24 * 60 * 60))

# Only in interactive shells, so scp/ssh commands and scripts aren't disturbed.
if [[ $- == *i* ]]; then
  # startup.sh hasn't run yet so the user bin directories may not be on PATH.
  CHEZMOI=$(PATH="$HOME/bin:$HOME/.local/bin:$PATH"; command -v chezmoi)

  if [ -n "$CHEZMOI" ]; then
    NOW=$(date +%s)
    LAST_UPDATE=$(cat "$LAST_UPDATE_FILE" 2>/dev/null)

    if [ -z "$LAST_UPDATE" ]; then
      # First run (e.g. just after `chezmoi init`): start the clock, don't update.
      echo "$NOW" > "$LAST_UPDATE_FILE"
    elif [ $((NOW - LAST_UPDATE)) -gt $UPDATE_INTERVAL ]; then
      # Written before updating so a failure (e.g. offline) doesn't retry on
      # every new shell for the rest of the week.
      echo "$NOW" > "$LAST_UPDATE_FILE"
      "$CHEZMOI" update
    fi
  fi
fi

. "$STARTUP"

unset SOURCE_DIR STARTUP LAST_UPDATE_FILE UPDATE_INTERVAL CHEZMOI NOW LAST_UPDATE
