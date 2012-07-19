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

# Case insensitive matching
shopt -s nocaseglob

PS1='\[\t\]'
# Prompt color based on location
if [ "$SSH_CONNECTION" == "" ]; then
  # Yellow prompt for local login
  PS1="$PS1\[\e[1;32m\][\u@\h \W]"
else
  PS1="$PS1\[\e[1;33m\][\u@\h \W]"
fi

# Ripped from Doug - color based on return code
PS1="$PS1\$(if [ \$? = 0 ]; then echo -e \"\$\"; else echo -e \"\[\033[0;31m\]\$\"; fi)\[\033[0m\] "

