# 启用vim
bindkey -v

# PROMPT setup
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats '(%b)'
precmd() { vcs_info }
setopt prompt_subst
PROMPT='%n@%m %1~ ${vcs_info_msg_0_}%# '
