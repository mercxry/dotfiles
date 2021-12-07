# macOS aliases
if [[ $OSTYPE == darwin* ]]; then
  alias flushdns="sudo killall -HUP mDNSResponder"
fi

# zsh aliases
alias zshrc="$EDITOR ~/.zshrc"
alias omz="$EDITOR ~/.oh-my-zsh"
alias omzc="$EDITOR ~/.oh-my-zsh/custom"
alias reload="source ~/.zshrc"
alias r="source ~/.zshrc"

# ls aliases
alias ls="exa"
alias l='ls -lFh'
alias la='ls -la'
alias ll='ls -l'
alias ldot='ls -ld .*'

# df aliases
alias df="duf"

# grep aliases
alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

# tail alias
alias t='tail -f'

# Command line head / tail shortcuts
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g M="| most"
alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
alias -g P="2>&1| pygmentize -l pytb"

# docker alias
alias d="docker"

# kubectl aliases
alias k="kubectl"
alias kgx="kubectl config get-contexts"

# networking alias
alias myip="curl http://ipecho.net/plain; echo"

# nodejs alias
alias rnm="rm -rf node_modules"

# chezmoi alias
alias c="chezmoi"

# vi(m) -> nvim alias
alias vi="nvim"
alias vim="nvim"

# Wake up desktop pc
alias wake-desktop="wakeonlan d0:50:99:2c:f0:f1"
