#!/bin/bash
set -euo pipefail

[ -z ${NIGHTLY_INSTDIR+x} ] && export NIGHTLY_INSTDIR=$HOME/.local/nvim
[ -z ${NVIM_CONFIG+x} ]     && export NVIM_CONFIG=$HOME/.config/nvim

########################
# Helper functions
die() {
  echo "$(tput setaf 9)[ ERROR]$(tput sgr0) $1"
  exit 255;
}

warn() {
  echo -e "$(tput setaf 11)[  WARN]$(tput sgr0) $1"
}

notice() {
  echo -e "$(tput setaf 10)[NOTICE]$(tput sgr0) $1"
}

noticen() {
  echo -en "$(tput setaf 10)[NOTICE]$(tput sgr0) $1"
}

ask() {
  CONFIRM=
  while [ -z $CONFIRM ]; do
    noticen "$1 [y/n] "

    read ans
    if { [ "$ans" == "y" ] || [ "$ans" == "n" ]; }; then
      CONFIRM=$ans
    fi
  done

  [ "$CONFIRM" == "y" ] && return 0
  return 1
}

########################
# Setup functions
check_depends() {
  DEPENDS="curl git python3 pip3"
  for dep in $DEPENDS; do
    if ! command -v $dep >/dev/null 2>&1; then
      echo "$dep missing and is required"
      exit 255
    fi
  done
}

check_fzf() {
  if ! command -v fzf >/dev/null 2>&1 || [ ! -d "$NVIM_CONFIG/pack/default/fzf" ]; then
    warn "fzf is required for part of this config."
    ask "Would you like to install fzf?" && return 1

    echo "Follow the instructions below to install fzf manually. Make sure to follow the Vim setup as well!"
    echo ""
    echo "    https://github.com/junegunn/fzf#installation"
  fi
}

install_fzf() {
  notice "Installing fzf to $HOME/.fzf"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf >/dev/null 2>&1
  ~/.fzf/install --all >/dev/null 2>&1

  cd "$NVIM_CONFIG/pack/default/start"
  ln -s $HOME/.fzf fzf
  cd - >/dev/null
}

install_nvim_python() {
  warn "neovim Python module not found (using $(which python3))"
  ask "Would you like to install it using pip3?" && ( pip3 install neovim >/dev/null || true )

  python3 -c 'import neovim' || warn "You will need to manually install the neovim Python module"
}

check_nvim() {
  if ! command -v nvim >/dev/null 2>&1; then
    warn "Neovim doesn't appear to be installed!"
    ask "Would you like to auto-install it to $NIGHTLY_INSTDIR?" && return 1

    warn "You will need to manually install Neovim"
    return 0
  fi
}

install_nvim() {
  TMP=$(mktemp -d)
  PWD=$(pwd)

  if [ "$(uname -m)" != "x86_64" ]; then
    die "This script can only install Neovim on x86_64. Please manually install nvim for your arch and re-run"
  fi

  notice "Installing Neovim.."

  mkdir -p $NIGHTLY_INSTDIR

  case "$(uname -s | tr '[:upper:]' '[:lower:]')" in
    "darwin")
      cd $TMP
      curl -L -O https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
      tar xf nvim-macos.tar.gz

      cp -r nvim-osx64/* $NIGHTLY_INSTDIR/
      cd - >/dev/null
      ;;

    "linux")
      cd $TMP
      curl -L --progress-bar -O https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
      tar xf nvim-linux64.tar.gz

      cp -r nvim-linux64/* $NIGHTLY_INSTDIR/
      cd - >/dev/null
      ;;

    *)
      die "This script can only install Neovim on macOS or linux. Please manually install nvim and re-run"
      ;;
  esac

  if [ -x "$NIGHTLY_INSTDIR/bin/nvim" ]; then
    notice "Make sure you add nvim to your \$PATH"
    echo ""
    echo "    export PATH=\"$NIGHTLY_INSTDIR/bin:\$PATH\""
    echo ""
  fi
}

########################
# Config functions
prep_config() {
  if [ -d $NVIM_CONFIG ]; then
    notice "Existing config found, checking source"

    cd $NVIM_CONFIG
    REMOTE=$(git remote get-url origin)
    cd - >/dev/null

    if { [ "$REMOTE" == 'git@github.com:ccakes/vimrc.git' ] || [ "$REMOTE" == 'https://github.com/ccakes/vimrc' ]; }; then
      return
    else
      # Directory is empty
      [ -z $(ls -A $NVIM_CONFIG) ] && return
    fi

    die "You have an existing nvim config at $NVIM_CONFIG. Manually back this up and ensure the directory is empty"
  fi

  mkdir -p $NVIM_CONFIG >/dev/null 2>&1 || true # will fail if exists but by this stage, we've confirmed its empty

  if [ ! -d $NVIM_CONFIG ]; then
    die "$NVIM_CONFIG still doesn't exist, check permissions and try again"
  fi
}

clone_or_update() {
  if [ ! -d "$NVIM_CONFIG/.git" ]; then
    notice "Cloning ccakes/vimrc -> $NVIM_CONFIG"

    git clone --depth 1 --recurse-submodules https://github.com/ccakes/vimrc $NVIM_CONFIG >/dev/null 2>&1

    if [ $? -ne 0 ]; then
      die "Something went wrong with git clone, check output above"
    fi
  else
    notice "Checking and updating ccakes/vimrc (incl submodules)"

    cd $NVIM_CONFIG
    git pull >/dev/null 2>&1
    git submodule update --remote >/dev/null
    cd - >/dev/null
  fi

  notice "ccakes/vimrc is up to date"
}

########################
# Post-install
update_rplugins() {
  notice "Running :UpdateRemotePlugins"

  $NIGHTLY_INSTDIR/bin/nvim -es +UpdateRemotePlugins +quit || true
}

check_depends
check_nvim || install_nvim

python3 -c 'import neovim' >/dev/null 2>&1 || install_nvim_python

prep_config
clone_or_update

update_rplugins

check_fzf || install_fzf