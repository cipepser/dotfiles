#--------------------------------------
# Command history configuration
#--------------------------------------
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups  # ignore duplication command history list
setopt hist_ignore_space # ignore when commands starts with space
setopt share_history     # share command history data

#-----------------------------------------------------
# import external config files
#-----------------------------------------------------
## set PATH to configuration files
export CONFIG=$HOME/Documents/config

source $CONFIG/zsh/env.zsh
source $CONFIG/zsh/nix.zsh
source $CONFIG/zsh/alias.zsh
source $CONFIG/zsh/plugins.zsh
source $CONFIG/zsh/prezto.zsh
source $HOME/.nix-profile/share/zsh-autosuggestions/zsh-autosuggestions.zsh

#-----------------------------------------------------
# general configuration for zsh
#-----------------------------------------------------
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

## Completion configuration
# FPATH の追加は nix.zsh で行っている (compinit/promptinit の前である必要があるため)。
autoload -Uz compinit
compinit

## color for ls command
export CLICOLOR=1

# color
# autoload -U colors
# colors

# # prompt user@host color
# COLOR_USER="%{$fg_bold[blue]%}"
# COLOR_RESET="%{$reset_color%}"
# COLOR_RED="%{$fg[red]%}"
# COLOR_CYAN="%{$fg[cyan]%}"
# COLOR_PID="%{$fg[blue]%}"

# # prompt configuration
# PROMPT="${COLOR_USER}%n${COLOR_RESET}$ "
# PROMPT2="${COLOR_RED}%_> ${COLOR_RESET}"
# RPROMPT='[`rprompt-git-current-branch` %~]:${COLOR_CYAN}$(echo $$)${COLOR_RESET}'
# SPROMPT="${COLOR_RED}correct?: %R -> %r [n,y,a,e]:${COLOR_RESET}"

eval "$(direnv hook zsh)"
# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# zsh-syntax-highlighting は他の widgets 定義の後に source する (推奨)
source $HOME/.nix-profile/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="$HOME/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
