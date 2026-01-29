# my-zshrc

自分用の zshrc 管理リポジトリ

## セットアップ

```bash
# リポジトリをクローン
git clone https://github.com/iQeda/my-zshrc-since-2026.git

# 既存ファイルをバックアップ（存在する場合）
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.backup
[ -f ~/.zshenv ] && mv ~/.zshenv ~/.zshenv.backup

# シンボリックリンクを作成
ln -s /path/to/my-zshrc/.zshrc ~/.zshrc
ln -s /path/to/my-zshrc/.zshenv ~/.zshenv

# 反映
source ~/.zshrc
```
