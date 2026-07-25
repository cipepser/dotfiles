# brew本体
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
git -C "$(brew --repo homebrew/core)" fetch --unshallow
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# ディレクトリ
mkdir $HOME/.go
mkdir $HOME/Documents/sand

# git（事前）
git config --global user.name "cipepser"
git config --global user.email "respepic@gmail.com"
git config --global color.ui auto
git config --global alias.co checkout

cd $HOME/Documents
git clone https://github.com/cipepser/config.git

# zsh
# zsh 本体は OS 付属の /bin/zsh (universal) を使う。
# brew の zsh を chsh すると、それが x86_64 専用ビルドだった場合に
# ログインシェル以降が丸ごと Rosetta 2 に落ちるため入れない。
# zsh-autosuggestions / zsh-completions / zsh-syntax-highlighting は nix 管理 (nix/home.nix)。
chsh -s /bin/zsh
brew install colordiff reattach-to-user-namespace tmux

## zplug プラグイン管理のため
cd $HOME
git clone https://github.com/zplug/zplug.git .zplug

## zprezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB

## z for zsh
## 移動したディレクトリを覚えておくため
git clone https://github.com/rupa/z.git ~/.zsh.d

exec $SHELL -l

# git
rm ~/.gitconfig
ln -s $CONFIG/git/.gitconfig ~/.gitconfig

# brew
brew install ghq
brew install peco
brew install nodejs
brew install hub
brew install jq
brew install go
brew install ripgrep
brew install direnv
brew install zplug
brew install tree
brew install gibo
brew install graphviz
brew install moreutils
brew install iproute2mac
brew install fd
brew install exa
brew install bat
brew install tokei
brew install pyenv
brew install aespipe
brew install python

# ctags
brew install ctags
alias ctags="`brew --prefix`/bin/ctags"

# zsh
rm $HOME/.zshrc
ln -s $HOME/Documents/config/zsh/.zshrc $HOME/.zshrc

# fzf
# ghqしたrepoへcdするために必要
git clone https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# peco
mkdir ~/.peco
ln -s $CONFIG/peco/config.json ~/.peco/config.json

# rust
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env

# udeps
cargo install cargo-udeps --locked

# karabiner
ln -s $CONFIG/karabiner/ctrl-kana-to-esc.json $HOME/.config/karabiner/assets/complex_modifications/ctrl-kana-to-esc.json
ln -s $CONFIG/karabiner/ctrl-m-to-enter.json $HOME/.config/karabiner/assets/complex_modifications/ctrl-m-to-enter.json

# カーソル速度
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 12

# 隠しファイルの表示
defaults write com.apple.finder AppleShowAllFiles TRUE 

# haskell
curl -sSL https://get.haskellstack.org/ | sh

# python
cd $HOME
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py
rm get-pip.py

# dbt
mkdir $HOME/.dbt
touch $HOME/.dbt/touch/profiles.yml
pip3 install dbt-bigquery
brew tap dbt-labs/dbt
brew install dbt-postgres
brew link --overwrite dbt-postgres
brew install --cask google-cloud-sdk
source $CONFIG/zsh/env.zsh

gcloud auth application-default login --scopes=https://www.googleapis.com/auth/bigquery,https://www.googleapis.com/auth/drive.readonly,https://www.googleapis.com/auth/iam.test
python3 -m pip install dbt-bigquery dbt-rpc

