PATH=$PATH:$GOPATH/bin
PATH=$PATH:$HOME/bin

source $HOME/.zsh_prompt

export EDITOR='vim'
export BUNDLER_EDITOR='vim'

alias be="bundle exec"
alias g="git"

source $HOME/.zshrc_local

# OSX specific
if [[ `uname` == 'Darwin' ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  PATH=/opt/homebrew/sbin:/opt/homebrew/bin:$PATH # Add sbin for homebrew

  unset PYTHONPATH # this is needed or else homebrew vim can have python version conflicts
fi

if [[ `uname` == 'Linux' ]]; then
  # default to the physical display
  export DISPLAY=:1.0

  displays () {
    ps aux | grep X | ruby -ne 'm = $_.split(/\s+/)[10..-1].join(" ").match(/:\d+/); puts m if m'
  }
fi

export GOPATH=$(go env GOPATH)

# enable ctrl-r history search in zsh
bindkey -v
bindkey '^R' history-incremental-search-backward

# TMUX
if [[ -e `which tmux` ]]; then
  if [[ -n `ps aux | grep tmux | grep -v grep` ]]; then
    if [[ -z "$TMUX" ]]; then
      tmux attach
    fi
  fi
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/clarketus/google-cloud-sdk/path.bash.inc' ]; then source '/Users/clarketus/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/clarketus/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/clarketus/google-cloud-sdk/completion.bash.inc'; fi

eval "$(rbenv init - zsh)"
