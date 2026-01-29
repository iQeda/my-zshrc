# my-zshrc-since-2026

自分用の zshrc 管理リポジトリ

## セットアップ

```bash
# リポジトリをクローン
git clone https://github.com/iQeda/my-zshrc-since-2026.git

# 既存の .zshrc をバックアップ（存在する場合）
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.backup

# シンボリックリンクを作成
ln -s /path/to/my-zshrc-since-2026/.zshrc ~/.zshrc

# 反映
source ~/.zshrc
```

## 依存ライブラリ

この .zshrc を使用するには、以下のツールが必要です。

```bash
# Homebrew（未インストールの場合）
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 各ツールのインストール
brew install starship    # プロンプトカスタマイズ
brew install jump        # ディレクトリジャンプ（z コマンド）
brew install fzf         # ファジーファインダー
brew install asdf        # 言語バージョン管理
brew install lazygit     # Git TUI
brew install yazi        # ファイルマネージャ
brew install ripgrep     # 高速 grep
brew install emacs       # エディタ
brew install ghq         # リポジトリ管理（fzf-tab のクローンに使用）

# fzf-tab（zsh 補完プラグイン）
ghq get Aloxaf/fzf-tab
```
