# nvim config

This is my Neovim config. There are many others like it, but this one is mine.

![perl example](/screenshots/screenshot-pl.png "Perl Example")
![js example](/screenshots/screenshot-js.png "Javascript Example")

It's useful to me in terminal nvim, it may work in a GUI client but I haven't tested that. This should also work fine with Vim 8.0+ (with some file renames) however that configuration is also untested.

## Installation

`bash bin/install.sh`

This will step through the installation checking that any required dependencies are installed. If you don't have Neovim, it'll prompt you to install the latest nightly under `$HOME`.

### fzf

The install script provides a link for installing `fzf`. In addition to having the binary on your path you should also symlink the install directory to your Vim plugins directory. Up to date instructions can be found in th [fzf readme](https://github.com/junegunn/fzf#as-vim-plugin).

## Updating

Re-running the install script will update everything or if you want some more control, you can jump into the config dir and pull directly.

```bash
cd $HOME/.config/nvim
git pull
git submodule update --remote
```
