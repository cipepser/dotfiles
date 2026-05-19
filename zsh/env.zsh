# sand box
export SAND=$HOME/Documents/sand

# golang
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin
export GO111MODULE="on"

# rust
export PATH=$PATH:$HOME/.cargo/bin

# python
export PATH=$PATH:/usr/local/opt/python/libexec/bin
export PYENV_ROOT=${HOME}/.pyenv
eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# geth
export PATH=$PATH:$HOME/Documents/sand/geth

# go-llvm
# export PATH="/usr/local/opt/llvm/bin:$PATH"

# git
export GIT_EDITOR=vim

# Atom
export EDITOR=vim

# haskell
export PATH=$PATH:$HOME/.local/bin
export PATH=$(stack path --local-bin):$PATH

# Application
export PATH=$PATH:/Applications
export PATH=$PATH:$HOME/.docker/bin

# claude
export PATH=$PATH:$HOME/.claude/local

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="$HOME/.rd/bin:$PATH"

eval "$(mise activate zsh)"

export LLM_OPS_USE_NIX=1