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

alias ..='cd ..'
alias ...='cd ../..'
