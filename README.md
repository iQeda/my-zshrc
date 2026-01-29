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
