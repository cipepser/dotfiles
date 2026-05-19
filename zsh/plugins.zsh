#--------------------------------------
# Prompt (pure prompt from nixpkgs)
#--------------------------------------
# pure prompt は ~/.nix-profile/share/zsh/site-functions/ にあり、
# FPATH 経由で autoload される (.zshrc で site-functions を FPATH に追加済み)。
autoload -U promptinit && promptinit
prompt pure

#--------------------------------------
# Command history configuration
#--------------------------------------
HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups  # ignore duplication command history list
setopt hist_ignore_space # ignore when commands starts with space
setopt share_history     # share command history data

function peco_select_history() {
  BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N peco_select_history
bindkey '^r' peco_select_history

#--------------------------------------
# change directory you visit recently
#--------------------------------------
source ~/.zsh.d/z.sh

function peco_recentd() {
  rd=`z -l | sort -nr | peco | awk '{ print $2 }'`
  if [ -n "$rd" ]; then
    BUFFER+="cd $rd"
    zle accept-line
  else
    zle reset-prompt
  fi
}
zle -N peco_recentd
bindkey '^x' peco_recentd

#--------------------------------------
# ghq directory
#--------------------------------------
function select_ghq_cd() {
  repo=`ghq list --full-path | peco | awk '{ print $1 }'`

  if [ -n "$repo" ]; then
    BUFFER+="cd $repo"
    zle accept-line
  else
    zle reset-prompt
  fi
}
zle -N select_ghq_cd
bindkey '^g' select_ghq_cd
