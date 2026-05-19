# nix-daemon.sh は /etc/zshrc で読み込まれるが、その後 ~/.zshrc 内で
# brew や mise が PATH に上書きしてくるため、nix の bin を先頭に再配置する。
# brew からの段階移行中は両方が PATH にいる状態を維持し、nix を優先させる。
if [ -d "$HOME/.nix-profile/bin" ]; then
  export PATH="$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH"
fi

# zsh-completions / pure prompt の関数を autoload できるよう FPATH を通す。
# compinit や promptinit より前に通す必要があるため nix.zsh で設定する。
if [ -d "$HOME/.nix-profile/share/zsh/site-functions" ]; then
  FPATH="$HOME/.nix-profile/share/zsh/site-functions:$FPATH"
fi
