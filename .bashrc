# [----------------------------------------------------------------------------]
# [----------------------------- PROMPT ---------------------------------------]
# [----------------------------------------------------------------------------]
hostn=$(hostname -s)
usern=$(whoami)

function prompt {
  ctime=$(date +%T)
  prmpt="[${PWD}][${ctime}]"
  let FILLS=${COLUMNS}-${#prmpt}
  LINE=""

  if [[ "$PWD" =~ "/home/$usern" ]]; then
    let FILLS=$FILLS+5+${#usern}
  fi

  for (( f=0; f<$FILLS; f++ ))  
  do   
    LINE=$LINE"\e[0;34;44m-"  
  done   

  PS1="\e[44;1;37m[\t] \w ${LINE}\e[0m\n"
  if [ "$SSH_CONNECTION" == "" ]; then
    PS1="$PS1\[\e[1;32;40m\][\u@\h]"
  else
    PS1="$PS1\[\e[1;33;40m\][\u@\h]"
  fi
  PS1="$PS1\$(if [ \$? = 0 ]; then echo -e \"\$\"; else echo -e \"\[\e[0;31m\]\$\"; fi)\[\e[0m\] "
} 
PROMPT_COMMAND=prompt

# [----------------------------------------------------------------------------]
# [----------------------------- ALIAS  ---------------------------------------]
# [----------------------------------------------------------------------------]

# Common parameters
alias ls='ls -v --color=auto'
alias ll='ls -lavh'
alias grep='grep --color'

# Seems like a better idea than it actually is?
#alias sudo='sudo env PATH=$PATH'

# move around
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# for git
alias get='git'
alias ga='git add'
alias gaa='git add .'
alias gs='git status'
alias gl='git log'
alias gcm='git commit -m'
alias gcf='git commit -F'

# random
alias calc='bc <<<'

# [----------------------------------------------------------------------------]
# [------------------------------ OTHER ---------------------------------------]
# [----------------------------------------------------------------------------]
# Case insensitive matching
shopt -s nocaseglob

# [----------------------------------------------------------------------------]
# [------------------------------ PATH ----------------------------------------]
# [----------------------------------------------------------------------------]
PATH=$PATH:$HOME/bin
