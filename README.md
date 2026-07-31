# .dotfiles

A repository to store my dotfiles and associated configuration. MIT Licensed.

## Install

```sh
git clone git@codeberg.org/amberstarlight/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bin/sync-dotfiles
```

> **Note**
> Darwin systems need [`homebrew`](https://brew.sh/).

## Programs

To get the best/full functionality out of my dotfiles, you'll need the following
programs. They are most likely available in your package manager, if not already
installed on your system. If you're using a Darwin (macOS) system, install a
package manager first, then update your copy of bash to a version made in the
current decade. If you're using Windows, install Linux instead. Alternatively,
you're on your own.

| Use case          | Program                                        |
| ----------------- | ---------------------------------------------- |
| Shell             | [Bash](https://www.gnu.org/software/bash/)     |
| Text editing      | [Helix](https://helix-editor.com/)             |
| Dotfile linking   | [GNU Stow](https://www.gnu.org/software/stow/) |

## Update

To update, use the `dotfiles` helper script. The command `sync` will fetch
and attempt to apply updates to the configuration. Run `exec bash` once this
has completed. For help, use `dotfiles help`.
