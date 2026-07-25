{ pkgs, ... }:

# 全ホスト共通の設定。username / homeDirectory やホスト固有パッケージは
# hosts/ 配下のモジュールで設定する。
{
  # 初回設定時の home-manager のバージョン。基本は変えない。
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  # brew から段階的に移行するパッケージはここに追加していく
  home.packages = with pkgs; [
    # 基本CLI
    jq
    tree
    wget
    file # libmagic を含む
    pstree
    moreutils
    colordiff
    nkf
    gibo
    unar

    # モダンな代替/高速ツール
    bat
    eza # exa の後継(exa は archived)
    fd
    ripgrep # rg 本体
    ripgrep-all # rga(複数フォーマット対応のrgラッパー)
    tokei
    difftastic
    peco

    # git周り
    gh
    ghq
    git-filter-repo
    hub

    # 開発系
    direnv # .zshrc の `eval "$(direnv hook zsh)"` 経由で hook
    tmux
    pandoc
    graphviz
    imagemagick
    ffmpeg
    ruff
    uv
    universal-ctags # brew の ctags の後継 (exuberant-ctags 互換)
    aespipe

    # zsh プラグイン (.zshrc から手動 source している)
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
    pure-prompt
  ];
}
