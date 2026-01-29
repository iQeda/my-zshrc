# ===========================================
# 環境変数
# ===========================================
export PATH="$HOME/.local/bin:$PATH"
export EDITOR=emacs

export FZF_DEFAULT_OPTS='
  --height 40%
  --layout=reverse
  --border
  --color=hl:#ff79c6,hl+:#bd93f9
'

# ===========================================
# シェル初期化
# ===========================================
eval "$(starship init zsh)"
eval "$(jump shell --bind=z)"
source <(fzf --zsh)

# ===========================================
# asdf
# ===========================================
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# ===========================================
# 補完設定
# ===========================================
fpath=($(brew --prefix asdf)/share/zsh/site-functions $fpath)
autoload -Uz compinit && compinit

# fzf-tab
source ~/ghq/github.com/Aloxaf/fzf-tab/fzf-tab.plugin.zsh

# ===========================================
# エイリアス
# ===========================================
alias lg='lazygit'
alias ..='cd ..'

# ===========================================
# 関数
# ===========================================

# Yazi - ファイルマネージャ
y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# rge - ripgrep + fzf → Emacs
rge() {
  if [[ "$PWD" == "$HOME" ]]; then
    echo "Warning: ホームディレクトリです。プロジェクトディレクトリで実行してください。"
    return 1
  fi

  local result
  if [[ -n "$1" ]]; then
    result=$(rg --line-number --column --color=always --smart-case \
        --hidden \
        --glob '!.git' \
        --glob '!node_modules' \
        "$1" . 2>/dev/null | \
      fzf --ansi \
          --delimiter : \
          --preview 'head -100 {1}' \
          --preview-window 'up,50%,border-bottom')
  else
    echo "パターンを指定してください: rge <pattern>"
    echo "または rgel で動的検索"
    return 1
  fi

  if [[ -n "$result" ]]; then
    local file line col
    file=$(echo "$result" | cut -d: -f1)
    line=$(echo "$result" | cut -d: -f2)
    col=$(echo "$result" | cut -d: -f3)
    emacs "+${line}:${col}" "$file"
  fi
}

# rgel - ripgrep + fzf 動的検索 → Emacs
rgel() {
  if [[ "$PWD" == "$HOME" ]]; then
    echo "Error: ホームディレクトリでは実行できません。プロジェクトディレクトリに移動してください。"
    return 1
  fi

  local RG_CMD="rg --column --line-number --no-heading --color=always --smart-case --hidden --glob '!.git' --glob '!node_modules'"
  local result
  result=$(FZF_DEFAULT_COMMAND="$RG_CMD ''" \
    fzf --ansi --disabled \
        --bind "start:reload:$RG_CMD {q} 2>/dev/null || true" \
        --bind "change:reload:sleep 0.1; $RG_CMD {q} 2>/dev/null || true" \
        --delimiter : \
        --preview 'head -100 {1}' \
        --preview-window 'up,50%')

  if [[ -n "$result" ]]; then
    local file line col
    file=$(echo "$result" | cut -d: -f1)
    line=$(echo "$result" | cut -d: -f2)
    col=$(echo "$result" | cut -d: -f3)
    emacs "+${line}:${col}" "$file"
  fi
}

# fe - ファイル検索 → Emacs
fe() {
  local file
  file=$(rg --files --hidden --glob '!.git' --glob '!node_modules' --glob '!Library' 2>/dev/null | \
    fzf --preview 'head -50 {}')
  [[ -n "$file" ]] && emacs "$file"
}
