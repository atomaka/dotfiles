# Common parameters
if [ "$OSTYPE" == "linux-gnu" ]; then
  alias ls='ls -v --color=auto'
  alias ll='ls -lav'
  alias grep='grep --color'
else
  alias ls='ls'
  alias ll='ls -la'
  alias grep='grep'
fi

alias dotfiles='cd; curl -#L https://github.com/atomaka/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README,.gitignore}; source ~/.profile'
alias npdev='sshfs -o idmap=user -o workaround=rename $USER@netprint:/data/test ~/Source/netprint'

alias gvim='gvim -f &'

# Case insensitive matching
shopt -s nocaseglob

PS1="\e[1;34m[\t] \w\n"
# Prompt color based on location
if [ "$SSH_CONNECTION" == "" ]; then
  # Yellow prompt for local login
  PS1="$PS1\[\e[1;32m\][\u@\h]"
else
  PS1="$PS1\[\e[1;33m\][\u@\h]"
fi

# Ripped from Doug - color based on return code
PS1="$PS1\$(if [ \$? = 0 ]; then echo -e \"\$\"; else echo -e \"\[\033[0;31m\]\$\"; fi)\[\033[0m\] "

