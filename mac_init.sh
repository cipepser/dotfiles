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
# repo名は dotfiles だが、$CONFIG（zsh/.zshrc）が $HOME/Documents/config を指すので
# clone 先のディレクトリ名は config に固定する
git clone https://github.com/cipepser/dotfiles.git config

# zsh
# zsh 本体は OS 付属の /bin/zsh (universal) を使う。
# brew の zsh を chsh すると、それが x86_64 専用ビルドだった場合に
# ログインシェル以降が丸ごと Rosetta 2 に落ちるため入れない。
# zsh-autosuggestions / zsh-completions / zsh-syntax-highlighting は nix 管理 (nix/home.nix)。
chsh -s /bin/zsh

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
# 以下は nix (nix/home.nix) に移行済みなので brew では入れない:
#   ghq peco hub jq ripgrep direnv tree gibo graphviz moreutils fd bat tokei
#   aespipe ctags(→universal-ctags) exa(→eza) ffmpeg pandoc uv wget colordiff
#   difftastic gh libmagic(→file) zsh-autosuggestions zsh-completions zsh-syntax-highlighting
# セットアップ手順は README の「nix (home-manager)」を参照。
brew install nodejs
brew install go

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

# claude code
# 設定・statusline・フックは config repo を SSoT にして symlink で参照する。
# 注意: symlink 先へ書き込むツール（jq > tmp && mv tmp file など）は
# symlink 自体を置き換えて壊すので、書き換えは `cat tmp > file` 側で行う。
mkdir -p ~/.claude/scripts ~/.claude/hooks
ln -s $CONFIG/claude/settings.json ~/.claude/settings.json
ln -s $CONFIG/claude/scripts/statusline.ts ~/.claude/scripts/statusline.ts
ln -s $CONFIG/claude/hooks/herdr-agent-state.sh ~/.claude/hooks/herdr-agent-state.sh

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

# gcloud
brew install --cask google-cloud-sdk
source $CONFIG/zsh/env.zsh

gcloud auth application-default login --scopes=https://www.googleapis.com/auth/bigquery,https://www.googleapis.com/auth/drive.readonly,https://www.googleapis.com/auth/iam.test

