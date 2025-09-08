#!/usr/bin/env bash

readonly PROGNAME=$(basename $0)
readonly PROGDIR=$(readlink -m $(dirname $0))
readonly ARGS="$@"

install_homebrew() {
  echo -n Checking homebrew...
  if command -v /opt/homebrew/bin/brew > /dev/null; then
    echo -n already installed...
  else
    echo -n installing...
    NONINTERACTIVE=1 /bin/bash -c "$(
      curl \
        --fail \
        --location \
        --show-error \
        --silent \
        https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
    )"
  fi
  echo done
}

install_shared_brew_packages() {
  echo -n Checking shared brew packages...
  missing_packages=$(
    comm -23  <(cat packages-shared-brew.txt) <(/opt/homebrew/bin/brew list --full-name | sort) \
      | tr "\n" " "
  )

  if [[ -z $missing_packages ]]; then
    echo -n already installed...
  else
    echo -n installing $missing_packages...
    /opt/homebrew/bin/brew install $missing_packages
  fi
  echo done
}

install_tmux_terminfo() {
  echo -n Checking Tmux terminfo...
  if infocmp tmux-256color > /dev/null; then
    echo -n already installed...
  else
    echo -n installling....
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
  echo done
}

install_fzf() {
  echo -n Checking fzf...
  if [[ $PATH =~ "fzf" ]]; then
    echo -n already installed...
  else
    echo -n installing...
    $(/opt/homebrew/bin/brew --prefix)/opt/fzf/install \
      --xdg \
      --no-update-rc \
      --key-bindings \
      --completion
  fi
  echo done
}

install_rust() {
  echo -n Checking Rust...
  if command -v rustup > /dev/null; then
    echo -n already installed...
  else
    echo -n installing...
    curl \
      --fail \
      --proto '=https' \
      --show-error \
      --silent \
      --tlsv1.2 \
      https://sh.rustup.rs \
        | sh -s -- -y --no-modify-path
  fi
  echo done
}

install_linux_packagges() {
  echo -n Checking Linux packages...
  packages=$(cat packages-linux-apt.txt | tr "\n" " ")
  if dpkg -s $packages >/dev/null 2>&1; then
    echo -n already installed...
  else
    echo -n installing...
    sudo apt-get install --assume-yes $packages
  fi
  echo done
}

install_darwin_brew_packages() {
  echo -n Checking Darwin brew packages...
  missing_packages=$(
    comm -23  <(cat packages-darwin-brew.txt) <(brew list --full-name | sort) \
      | tr "\n" " "
  )

  if [[ -z $missing_packages ]]; then
    echo -n already installed...
  else
    echo -n installing $missing_packages...
    /opt/homebrew/bin/brew install $missing_packages
  fi
  echo done
}

install_darwin_brew_cask_packages() {
  echo -n Checking Darwin brew cask packages...
  package_files="packages-darwin-brew-cask.txt"
  if [[ $ARGS == "personal" ]]; then
    package_files+=" packages-darwin-brew-cask-personal.txt"
  fi
  if [[ $ARGS == "work" ]]; then
    package_files+=" packages-darwin-brew-cask-work.txt"
  fi

  missing_packages=$(
    comm -23  <(cat $package_files | sort) <(/opt/homebrew/bin/brew list --full-name | sort) \
      | tr "\n" " "
  )

  if [[ -z $missing_packages ]]; then
    echo -n already installed...
  else
    echo -n installing $missing_packages...
    /opt/homebrew/bin/brew install --cask $missing_packages
  fi
  echo done
}

install_darwin_profile_hack() {
  echo -n Checking profile hack...
  if [[ ! -f /etc/zprofile ]]; then
    echo -n already installled...
  else
    echo -n installing...
    sudo mv /etc/{zprofile,zprofile.old}
  fi
  echo done
}

install_rosetta() {
  echo -n Installing Rosetta...
  if pkgutil --pkg-info com.apple.pkg.RosettaUpdateAuto &> /dev/null; then
    echo -n already installled...
  else
    echo -n installing...
    softwareupdate --install-rosetta --agree-to-license
  fi
  echo done
}

install_env() {
  echo -n Checking zshenv available...
  if [[ -z $HOMEBREW_PREFIX ]]; then
    echo -n already installed...
  else
    echo -n installling...
    source ~/dotfiles/zsh/.zshenv
  fi
  echo done
}

install_stow_paths() {
  /opt/homebrew/bin/stow bin ghostty git mise nvim ruby tmux zsh
}

install_ssh_config() {
  echo -n Checking SSH config...
  if [[ ! -f ~/.ssh/config ]]; then
    echo -n installing...
    mkdir -p ~/.ssh
    cp ./ssh/.ssh/config ~/.ssh/config
  else
    if cmp -s ./ssh/.ssh/config ~/.ssh/config; then
      echo -n already installed...
    else
      echo -n different config found...
      diff_output=$(diff ~/.ssh/config ./ssh/.ssh/config)
      adds=$(echo "$diff_output" | grep -c '^>' || true)
      removes=$(echo "$diff_output" | grep -c '^<' || true)
      echo -n "$removes removes, $adds adds..."
    fi
  fi
  echo done
}

install_linux() {
  if ! command -v apt-get > /dev/null; then
    echo apt-get is required, but not available
    exit 1
  fi

  install_linux_packagges
  install_homebrew
  install_env
  install_shared_brew_packages
  install_fzf
  install_rust
  install_stow_paths
}

install_darwin() {
  install_darwin_profile_hack
  install_homebrew
  install_env
  install_shared_brew_packages
  install_fzf
  install_rust
  install_rosetta
  install_darwin_brew_packages
  install_darwin_brew_cask_packages
  install_tmux_terminfo
  install_stow_paths
  install_ssh_config
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
}

main
