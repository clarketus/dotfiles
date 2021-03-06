PATH=$PATH:$GOPATH/bin
PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
source $HOME/.bash_prompt

export EDITOR='vim'
export BUNDLER_EDITOR='vim'

alias be="bundle exec"
alias g="git"

source $HOME/.bash_profile_local

export GOPATH=$(go env GOPATH)

# OSX specific
if [[ `uname` == 'Darwin' ]]; then
  PATH=/usr/local/sbin:/usr/local/bin:$PATH # Add sbin for homebrew

  # allow homebrew ruby to override system ruby
  # this is needed so we can use homebrew vim
  export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/2.5.0/bin/:$PATH"

  bind "set completion-ignore-case on"
  bind "set show-all-if-ambiguous on"

  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
    complete -o default -F _git g
  fi

  unset PYTHONPATH # this is needed or else homebrew vim can have python version conflicts
fi

if [[ `uname` == 'Linux' ]]; then
  # default to the physical display
  export DISPLAY=:1.0

  displays () {
    ps aux | grep X | ruby -ne 'm = $_.split(/\s+/)[10..-1].join(" ").match(/:\d+/); puts m if m'
  }
fi

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

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
