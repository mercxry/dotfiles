# paths, keep this at the top!
set BREW_PATH (brew --prefix)
fish_add_path $BREW_PATH/bin
fish_add_path $BREW_PATH/opt/llvm/bin
fish_add_path $BREW_PATH/opt/ruby/bin
fish_add_path $BREW_PATH/opt/postgresql@16/bin
fish_add_path ~/go/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.local/bin
fish_add_path ~/.local/share/nvim/mason/bin
fish_add_path ~/.asdf/shims
fish_add_path ~/google-cloud-sdk/bin
fish_add_path ~/.modular/pkg/packages.modular.com_mojo/bin
fish_add_path ~/.yarn/bin
fish_add_path ~/.dotnet/tools
fish_add_path /usr/local/share/dotnet
fish_add_path /Library/TeX/texbin

# envs
set -g fish_greeting
set -gx EDITOR (which nvim)

# ulimit
ulimit -n 524288

# shell programs
starship init fish | source
zoxide init fish | source
direnv hook fish | source
atuin init fish | source
fnm env --use-on-cd | source

# load theme
source ~/.config/fish/themes/kanagawa.fish

# load the rest of the config files
for file in ~/.config/fish/conf.d/*.fish
    source $file
end
