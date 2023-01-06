ZDOTDIR=$HOME/.config/zsh

XDG_CONFIG_HOME="$HOME/.config"

PERSONAL_BIN_PATH="$HOME/bin"
PERSONAL_FPATH="$ZDOTDIR/completions"

NODENV_PATH="$HOME/.nodenv/bin"
RBENV_PATH="$HOME/.rbenv/bin"
TFENV_PATH="$HOME/.tfenv/bin"
PYENV_PATH="$HOME/.pyenv/bin"

CARGO_PATH="$HOME/.cargo/bin"

if [[ "$OSTYPE" == darwin* ]]; then
  HOMEBREW_PREFIX="/opt/homebrew"
  HOMEBREW_CELLAR="/opt/homebrew/Cellar"
  HOMEBREW_REPOSITORY="/opt/homebrew"

  GNU_SED_PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin"
  GNU_TAR_PATH="/opt/homebrew/opt/gnu-tar/libexec/gnubin"
  GNU_TOOLS_PATH="/opt/homebrew/opt/coreutils/libexec/gnubin"
  GNU_TOOLS_MAN_PATH="/opt/homebrew/opt/coreutils/libexec/gnuman"

  PATH="/usr/local/bin:/Library/Apple/usr/bin:$PATH"

  PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
  MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
  INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

  [[ -d "$GNU_SED_PATH" ]] && PATH="$GNU_SED_PATH:$PATH"
  [[ -d "$GNU_TAR_PATH" ]] && PATH="$GNU_TAR_PATH:$PATH"
  [[ -d "$GNU_TOOLS_PATH" ]] && PATH="$GNU_TOOLS_PATH:$PATH"
  [[ -d "$GNU_TOOLS_MAN_PATH" ]] && MANPATH="$GNU_TOOLS_MAN_PATH:$MANPATH"
elif [[ "$OSTYPE" == linux* ]]; then
  HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew";
  HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar";
  HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew";

  PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin${PATH+:$PATH}";

  MANPATH="/home/linuxbrew/.linuxbrew/share/man${MANPATH+:$MANPATH}:";
  INFOPATH="/home/linuxbrew/.linuxbrew/share/info:${INFOPATH:-}";
fi

[[ -d "$RBENV_PATH" ]] && PATH="$RBENV_PATH:$PATH"
[[ -d "$NODENV_PATH" ]] && PATH="$NODENV_PATH:$PATH"
[[ -d "$TFENV_PATH" ]] && PATH="$TFENV_PATH:$PATH"
[[ -d "$PYENV_PATH" ]] && PATH="$PYENV_PATH:$PATH"
[[ -d "$CARGO_PATH" ]] && PATH="$CARGO_PATH:$PATH"
[[ -d "$PERSONAL_BIN_PATH" ]] && PATH="$PERSONAL_BIN_PATH:$PATH"
[[ -d "$PERSONAL_FPATH" ]] && FPATH="$PERSONAL_FPATH:$FPATH"

# EDITOR
if command -v nvim > /dev/null; then
  export {EDITOR,GIT_EDITOR}=nvim
else
  export {EDITOR,GIT_EDITOR}=vim
fi

# Don't let Debian distributions run compinit
skip_global_compinit=1
