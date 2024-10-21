# ls aliases
set LS_CMD "eza"
alias ls "$LS_CMD"
alias l "$LS_CMD -lFh"
alias la "$LS_CMD -la"
alias ll "$LS_CMD -l"
alias ldot "$LS_CMD -ld .*"

# grep aliases
alias grep "grep --color"
alias sgrep "grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS}"

# networking alias
alias myip "curl https://ipv4.icanhazip.com; printf"

# Wake up gaming desktop pc
alias wake-gaming "tailscale up; ssh berry 'wakeonlan 04:42:1a:98:36:14'; tailscale down"
