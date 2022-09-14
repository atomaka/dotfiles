#!/usr/bin/env bash

install_homebrew() {
  if ! command -v brew > /dev/null; then
    NONINTERACTIVE=1 /bin/bash -c "$(
      curl \
        --fail \
        --location \
        --show-error \
        --silent \
        https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
    )"
  fi
}

install_shared_applications() {
  brew install direnv fzf git stow the_silver_searcher tmux \
    vim zsh rbenv ruby-build tfenv nodenv node-build tig libpq gnupg llvm \
    awscli cmake jq watch gh

  install_alacritty_terminfo
  install_rust
  install_vim
}

install_alacritty() {
  if ! command -v alacritty > /dev/null; then
    cargo install alacritty

    curl \
      --fail \
      --location \
      --output /tmp/Alacritty.svg \
      https://raw.githubusercontent.com/alacritty/alacritty/master/extra/logo/alacritty-term.svg

    curl \
      --fail \
      --location \
      --output /tmp/Alacritty.desktop \
      https://raw.githubusercontent.com/alacritty/alacritty/master/extra/linux/Alacritty.desktop

    sudo mv /tmp/Alacritty.svg /usr/share/pixmaps/Alacritty.svg
    sudo desktop-file-install /tmp/Alacritty.desktop
    sudo update-desktop-database
  fi
}

install_alacritty_terminfo() {
  if ! infocmp alacritty > /dev/null; then
    curl \
      --fail \
      --location \
      --output /tmp/alacritty.info \
      https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info

    sudo tic -xe alacritty,alacritty-direct /tmp/alacritty.info
    $HOME/dotfiles/bin/bin/toggle-color-mode
  fi
}

install_rust() {
  if ! command -v rustup > /dev/null; then
    curl \
      --fail \
      --proto '=https' \
      --show-error \
      --silent \
      --tlsv1.2 \
      https://sh.rustup.rs \
        | sh -s -- -y --no-modify-path
  fi
}

install_vim() {
  if ! test -f ~/.vim/autoload/plug.vim > /dev/null; then
    curl \
      --create-dirs \
      --fail \
      --location \
      --output ~/.vim/autoload/plug.vim \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi
}

install_linux() {
  if ! command -v apt-get > /dev/null; then
    echo apt-get is required, but not available
    exit 1
  fi

  packages="build-essential procps curl file git cmake pkg-config\
    libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev\
    libxkbcommon-dev python3"
  dpkg -s $packages >/dev/null 2>&1 \
    || sudo apt-get install --assume-yes $packages

  install_homebrew
  source ~/dotfiles/zsh/.zshenv
  install_shared_applications

  # gui
  install_alacritty
}

install_darwin() {
  install_homebrew
  sudo mv /etc/{zprofile,zprofile.old}
  source ~/dotfiles/zsh/.zshenv
  install_shared_applications

  softwareupdate --install-rosetta
  brew install coreutils gnu-sed session-manager-plugin

  # gui
  brew install --cask docker rectangle slack google-chrome alacritty telegram \
    discord element
}

main() {
  os=$(uname | tr '[:upper:]' '[:lower:]')
  case $os in
    linux | darwin)
      install_$os
      ;;
    *)
      echo $os not supported
      exit 1
      ;;
  esac

  stow alacritty bin git ruby tmux vim zsh
}

main
