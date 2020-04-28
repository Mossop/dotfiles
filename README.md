There are my personal [dotfiles](https://dotfiles.github.io/) and my hacked
together install/update system. Honestly there is probably not much here of
interest to anyone else, most of these notes are for my own benefit so I
remember how this all works.

## Installing

Something similar to the following:

```
curl https://raw.githubusercontent.com/Mossop/dotfiles/master/bootstrap | sh
```

This will download and install the repo to `$HOME/dotfiles` and install the
configuration files and update `$HOME/.profile` to call `$HOME/dotfiles/scripts/startup.sh`
on login.

Under the hood the [`bootstrap`](https://github.com/Mossop/dotfiles/blob/master/bootstrap)
script attempts to download the contents of this repository and extract it to
`$HOME/dotfiles`. It will prefer to use `git` if installed but will fall back to
using curl or wget to download an archive of the current state of the repository.

After extraction [`scripts/post-bootstrap.sh`](https://github.com/Mossop/dotfiles/blob/master/scripts/post-bootstrap.sh)
is executed which writes the dotfile configuration file to `$HOME/dotfiles/.config`
and then executes [`install`](https://github.com/Mossop/dotfiles/blob/master/install)
to actually install everything.

## Updating

```
dotfiles/update
```

The actual updating is performed by [`scripts/do-update.sh`](https://github.com/Mossop/dotfiles/blob/master/scripts/do-update.sh)
which is copied to a temporary location before being executed in case the update
process modifies that file.

The update process attempts to use `git` to update the repository. If dotfiles
was not installed with git then it downloads the current archive of dotfiles and
extracts it to a temporary directory. The current dotfiles directory is wiped
excluding the `.config` file and then the new files are copied into place.

Afterwards [`scripts/post-update.sh`](https://github.com/Mossop/dotfiles/blob/master/scripts/post-update.sh)
is executed which removes the temporary update script and then executes
[`install`](https://github.com/Mossop/dotfiles/blob/master/install) to install
everything.
