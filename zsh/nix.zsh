# nix-daemon.sh は /etc/zshrc で読み込まれるが、その後 ~/.zshrc 内で
# brew や mise が PATH に上書きしてくるため、nix の bin を先頭に再配置する。
# brew からの段階移行中は両方が PATH にいる状態を維持し、nix を優先させる。
if [ -d "$HOME/.nix-profile/bin" ]; then
  export PATH="$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH"
fi
