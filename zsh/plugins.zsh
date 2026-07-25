#--------------------------------------
# Prompt (pure prompt from nixpkgs)
#--------------------------------------
# pure prompt は ~/.nix-profile/share/zsh/site-functions/ にあり、
# FPATH 経由で autoload される (.zshrc で site-functions を FPATH に追加済み)。
autoload -U promptinit && promptinit
# promptinit が FPATH から見つけた theme が prompt_themes に入る。
# nix (home-manager) 未適用だと pure がないので、その場合は zsh 標準の prompt に任せる。
if (( ${prompt_themes[(I)pure]} )); then
  prompt pure
fi

function peco_select_history() {
  BUFFER=`history -rn 1 | awk '!a[$0]++' | peco`
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
