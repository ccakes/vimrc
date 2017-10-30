# nvim config

This is my Neovim config. There are many others like it, but this one is mine.

![perl example](/screenshots/screenshot-pl.png "Perl Example")
![js example](/screenshots/screenshot-js.png "Javascript Example")

It's useful to me in terminal nvim, it may work in a GUI client but I haven't tested that. This should also work fine with Vim 8.0+ (with some file renames) however that configuration is also untested.

## Installation

 `bash -c "$(curl -fsL https://git.io/ccakes-vimrc)"`

For the brave amongst us, the command above is a copy-paste installer. Otherwise, the link above points to `bin/install.sh` so you're able to clone locally and run that to avoid piping code from the internet directly to your shell interpreter.

This will step through the installation checking that any required dependencies are installed. If you don't have Neovim, it'll prompt you to install the latest nightly under `$HOME`.

### Python

Deoplete requires Python 3.

`g:python3_host_prog` in [init.vim](init.vim) may require tweaking if you're using [pyenv](https://github.com/pyenv/pyenv) or similar.

### fzf

The install script can optionally install `fzf` for you.

If you say no, it'll provide a link to instructions. If you take the manual route, in addition to having the binary on your path you should also symlink the install directory to your Vim plugins directory. Up to date instructions can be found in the [fzf readme](https://github.com/junegunn/fzf#as-vim-plugin).

## Updating

Re-running the install script will update everything or if you want some more control, you can jump into the config dir and pull directly.

```bash
cd $HOME/.config/nvim
git pull
git submodule update --remote
```
