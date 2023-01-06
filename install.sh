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
    awscli cmake jq watch gh nvim openssl@1.1 openssl@3 readline libyaml gmp \
    pyenv

  install_fzf
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
    sudo ln -s /home/$USER/.cargo/bin/alacritty /usr/local/bin/alacritty
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
  fi
}

install_tmux_terminfo() {
  if ! infocmp tmux-256color > /dev/null; then
    curl \
      --fail \
      --location \
      --output /tmp/tmux-256color.src.gz \
      https://invisible-island.net/datafiles/current/terminfo.src.gz

    pushd /tmp
    gunzip tmux-256color.src.gz
    sed -i 's/pairs#0x10000/pairs#32767/g' tmux-256color.src

    sudo tic -xe tmux-256color tmux-256color.src
    popd
  fi
}

install_fzf() {
  $(brew --prefix)/opt/fzf/install \
    --xdg \
    --no-update-rc \
    --key-bindings \
    --completion
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
  if ! test -d ~/.local/share/nvim/site > /dev/null; then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
      ~/.local/share/nvim/site/pack/packer/start/packer.nvim
  fi
}

install_linux() {
  if ! command -v apt-get > /dev/null; then
    echo apt-get is required, but not available
    exit 1
  fi

  packages="build-essential procps curl file git cmake pkg-config\
    libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev\
    libxkbcommon-dev python3 libssl-dev xclip"
  dpkg -s $packages >/dev/null 2>&1 \
    || sudo apt-get install --assume-yes $packages

  install_homebrew
  source ~/dotfiles/zsh/.zshenv
  install_shared_applications

  # gui
  install_alacritty
  install_alacritty_terminfo
}

install_darwin() {
  install_homebrew
  [[ -f /etc/zprofile ]] && sudo mv /etc/{zprofile,zprofile.old}
  source ~/dotfiles/zsh/.zshenv
  install_shared_applications

  softwareupdate --install-rosetta --agree-to-license
  brew install coreutils gnu-sed session-manager-plugin

  # gui
  brew install --cask docker rectangle slack google-chrome alacritty telegram \
    discord element brave-browser zoom notion

  install_tmux_terminfo
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

  stow alacritty bin git nvim ruby tmux zsh

  $HOME/dotfiles/bin/bin/toggle-color-mode
}

main
