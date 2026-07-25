# config
個人的な設定ファイルの置き場です

## nix (home-manager)
CLIツールはbrewからnixへ段階的に移行中。`nix/`配下で管理している。

| ファイル | 役割 |
| --- | --- |
| `nix/flake.nix` | ホスト一覧(system / モジュール)の定義 |
| `nix/home.nix` | 全ホスト共通のパッケージ |
| `nix/hosts/work.nix` | 仕事用Mac (`masanori.onda` / aarch64-darwin) |
| `nix/hosts/personal.nix` | 個人用Mac (`cipepser` / aarch64-darwin) |

### 新しいマシンでのセットアップ

#### 0. Rosettaで動いていないか確認する (Apple Silicon)

```sh
sysctl -n sysctl.proc_translated  # 1 なら Rosetta 2 配下
lipo -archs $SHELL                # ログインシェルが x86_64 だけなら Rosetta 確定
```

ログインシェルがx86_64専用バイナリだと、ターミナルがarm64ネイティブでもそこから先が全部Rosettaに落ちる。この状態でnixを入れると`x86_64-darwin`のnixが入ってしまうので、先にログインシェルをuniversalな`/bin/zsh`へ戻す。

```sh
chsh -s /bin/zsh
```

ターミナルを開き直して`uname -m`が`arm64`になったことを確認してから次へ進む。

#### 1. nix本体をインストール

flakesが有効になる。sudoが必要。

```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

#### 2. home-managerを初回適用

シェルを開き直してから、`flake.lock`で固定したhome-managerで適用する。

```sh
cd $HOME/Documents/config/nix
nix build .#homeConfigurations.$(whoami).activationPackage
./result/activate
```

### 2回目以降

`programs.home-manager.enable`で`home-manager`コマンド自体が入るので、以降はこれだけ。

```sh
home-manager switch --flake $HOME/Documents/config/nix#$(whoami)
```

ホストを増やすときは`nix/flake.nix`の`hosts`にusernameをキーとして追加し、`nix/hosts/`にそのマシン用のモジュールを置く。

なお`zsh/nix.zsh`で`~/.nix-profile/bin`をPATHの先頭に再配置しているため、brewとnixの両方に同じコマンドがある間はnixが優先される。

## Mac
`mac_init.sh`から復旧

### インストーラを使う
- dropbox
- chrome
- vscode
- atom
- 1password
- iterm2
- google日本語入力
- googleバックアップ
- appcleaner
- slack
- alfred
- bettertouchtool: システム環境設定のユーザとグループで起動時に自動的に開くよう追加
- karabiner
- firefox
- discord
- skype
- brave browser
- wireshark
- clipy
- vagrant
- virtualbox
- goland
- idea
- docker for mac
- line

### iterm2

Preferences -> Profiles -> General -> Working Directory  
で`Reuse previous session's directory`を選択

Preferences -> Appearance  
で`Show tab bar even when there is only one tab`を選択

Preferences -> Profile -> Text  
で`Vertial bar`と`Blinking cursor`を選択

[Mac iTerm で iceberg のテーマを使う \- Qiita](https://qiita.com/tarosaiba/items/fcc399006025ebe9152c)を参考にカラーテーマを変更。

Preferences -> Profiles -> Terminal -> Notifications
で`Silence bell`を選択

### sshの設定

- 鍵を生成して、githubに登録（`~/.ssh/config`も`HostName`, `IdentityFile`, `User`を設定。 [github](https://docs.github.com/ja/enterprise-cloud@latest/authentication/authenticating-with-saml-single-sign-on/authorizing-an-ssh-key-for-use-with-saml-single-sign-on)側で `Enable SSH` が必要なことに注意）


### VS code

[ブログ](https://cipepser.hatenablog.com/entry/setting-for-vscode)にまとめてある。
→2022/7/29現在、Githubアカウント経由でSettings Syncを利用しているので手動設定不要