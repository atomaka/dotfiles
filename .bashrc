# Common parameters
alias ls='ls -lav --color=auto'
alias grep='grep --color'

# editor
alias sublime='nohup /cygdrive/c/Program\ Files/Sublime\ Text\ 2/sublime_text.exe > /dev/null'

# non-standard ssh port
alias vps='ssh vps.p5dev.com -p 60013'

# clear the screen
#alias cls='echo -n ^[[2J'

# Case insensitive matching
shopt -s nocaseglob

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
