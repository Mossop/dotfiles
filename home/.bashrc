export MISE="{{ mise_bin }}"
export MISE_CONFIG_DIR="{{ vars.DOTFILES }}/shared/mise"
. "{{ vars.DOTFILES }}/scripts/maybe_update" "{{ vars.DOTFILES }}" "{{ vars.DOTFILES }}/scripts/startup"
