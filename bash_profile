PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
source $HOME/.bash_prompt

export EDITOR='vim -f'
export BUNDLER_EDITOR='vim -f'

alias be="bundle exec"
alias mysql_login="mysql -u root --password=password"
alias g="git"

alias fbtunnel="ssh -v -o TCPKeepAlive=yes -o ServerAliveInterval=10 -o ServerAliveCountMax=2 -CNR cartman.node.wfhack.com:9999:127.0.0.1:9999 wildfire@cartman.node.wfhack.com"
alias fbtunnel_clarketus="ssh -v -o TCPKeepAlive=yes -o ServerAliveInterval=10 -o ServerAliveCountMax=2 -CNR tunnel.clarketus.com:9999:127.0.0.1:9999 deploy@tunnel.clarketus.com"

# OSX specific
if [[ `uname` == 'Darwin' ]]; then
  PATH=/usr/local/sbin:/usr/local/bin:$PATH # Add sbin for homebrew

  bind "set completion-ignore-case on"
  bind "set show-all-if-ambiguous on"

  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
    complete -o default -F _git g
  fi

  # needed for homebrew installed python packages
  export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
fi

if [[ `uname` == 'Linux' ]]; then
  # default to the physical display
  export DISPLAY=:0

  displays () {
    ps aux | grep X | ruby -ne 'm = $_.split(/\s+/)[10..-1].join(" ").match(/:\d+/); puts m if m'
  }
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# TMUX
if [[ -e `which tmux` ]]; then
  if [[ -n `ps aux | grep tmux | grep -v grep` ]]; then
    if [[ -z "$TMUX" ]]; then
      tmux attach
    fi
  fi
fi

source $HOME/.bash_profile_local

