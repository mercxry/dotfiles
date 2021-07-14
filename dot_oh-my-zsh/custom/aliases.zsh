# macOS aliases
if [[ $OSTYPE == darwin* ]]; then
  alias flush="sudo killall -HUP mDNSResponder"
fi

# zsh aliases
alias zshrc="$EDITOR ~/.zshrc"
alias zshconfig="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"
alias reload="source ~/.zshrc"
alias r="source ~/.zshrc"

# ls aliases
alias ls="exa"
alias la="ls -la"

# docker aliases
alias d="docker"

# kubectl aliases
alias k="kubectl"
alias kgx="kubectl config get-contexts"

# networking aliases
alias myip="curl http://ipecho.net/plain; echo"

# javascript aliases
alias y="yarn"
alias rnm="rm -rf node_modules"

