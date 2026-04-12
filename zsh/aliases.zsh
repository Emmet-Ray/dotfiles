if command -v eza >/dev/null 2>&1; then
  alias ls='eza'
  alias ll='eza -lh --icons'
  alias la='eza -a'
  alias lla='ll -a'
else
  alias ll='ls -lh'
  alias la='ls -a'
  alias lla='ls -alh'
fi

# system
alias ..='cd ..'
alias ...='cd ../..'

# git
alias ginit='git init'
alias gs='git status'
alias gss='git status -s'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gb='git branch'
alias gco='git checkout'
alias glog='git log'
alias glast='git log -1'
alias ggraph='git log --oneline --graph --decorate --all'
alias gunstage='git restore --staged --'