# macOS aliases
if test "$OSTYPE" = "darwin"
    abbr flushdns "sudo killall -HUP mDNSResponder"
end

# fish aliases
set FISH_CONFIG ~/.config/fish/config.fish
abbr fishrc "$EDITOR $FISH_CONFIG"
abbr reload "source $FISH_CONFIG"

# df
abbr df "duf"

# abbreviations 
abbr b "brew"
abbr d "docker"
abbr pn "pnpm"
abbr k "kubectl"
abbr kgx "kubectl config get-contexts"
  
# chezmoi 
abbr c "chezmoi"

# v(i[m]) -> nvim 
abbr v "nvim"
abbr vi "nvim"
abbr vim "nvim"
