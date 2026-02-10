# aliases
ZSHRC_DIR="${${(%):-%N}:A:h}"
ALIAS_PATH="$ZSHRC_DIR/aliases.zsh"
[ -f "$ALIAS_PATH" ] && source "$ALIAS_PATH"

# local API keys
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# 设置初始窗口大小
printf '\e[8;30;110t'
# 启用vim
bindkey -v
bindkey "^R" history-incremental-search-backward

# PROMPT setup
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats '(%b)'
precmd() { vcs_info }
setopt prompt_subst
PROMPT='%n@%m %1~ ${vcs_info_msg_0_}%# '

# cmd config
## zoxide(improved cd)
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# zsh配置
## zsh插件
if [[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
if [[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
## fzf (Homebrew)
if [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
fi
if [[ -f /opt/homebrew/opt/fzf/shell/completion.zsh ]]; then
  source /opt/homebrew/opt/fzf/shell/completion.zsh
fi

# 自定义函数
## Safe rename function
rename() {
  if [ $# -ne 2 ]; then
    echo "Usage: rename 'old_name' 'new_name'"
    return 1
  fi

  old="$1"
  new="$2"

  if [ ! -e "$old" ]; then
    echo "Error: '$old' does not exist."
    return 1
  fi

  if [ -e "$new" ]; then
    read -r "reply?$new already exists. Overwrite? (y/N) "
    case "$reply" in
      [Yy]*) ;;
      *) echo "Rename canceled."; return 1 ;;
    esac
  fi

  # Use quotes to handle spaces/special chars
  mv -- "$old" "$new"
  if [ $? -eq 0 ]; then
    echo "Renamed '$old' -> '$new'"
  else
    echo "Rename failed."
  fi
}

