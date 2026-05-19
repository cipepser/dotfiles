# shell
alias ll='ls -l'
# alias la='ls -la'

# git
alias g='git'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gpl='git pull'
alias gs='git status'
alias gsi='git status --ignored'
alias gr='git rm'
alias gd='git diff'
alias gcho='git checkout'
alias gchob='git checkout -b'
alias gf='git fetch'
alias gb='git branch -a'
alias gbd='git branch -D'
alias gsw='git switch'
alias gswc='git switch -c'
alias grs='git restore'

# docker
alias d='docker'
alias dm='docker-machine'
alias dp='docker ps'
alias di='docker images'
alias dn='docker network'
alias dc='docker-compose'

# kubernetes
alias k='kubectl'

# python
alias p='python3'
alias pip='pip3'

# bitcoin core
alias bitd='bitcoind'
alias bcli='bitcoin-cli'

# alias for directories
setopt auto_cd
setopt cdable_vars
hash -d gop=~/.go/src/github.com/cipepser
hash -d down=~/Downloads
hash -d sand=$SAND
hash -d config=$CONFIG
hash -d samp=$SAND/mysamples

# editor/IDE
alias idea='open -a "`ls -dt /Applications/IntelliJ\ IDEA*|head -1`"'
alias goland='open -a "`ls -dt /Applications/Goland.app|head -1`"'

# exa
alias exa='exa -lha --git'
alias la='exa'

# isucon
alias ns='notify_slack -snippet'
alias nsd='notify_slack'
