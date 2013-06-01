PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
source /Users/clarketus/.bash_prompt

export EDITOR='vim -f'
export BUNDLER_EDITOR='vim -f'

alias be="bundle exec"
alias mysql_login="mysql -u root --password=password"

alias fbtunnel="ssh -v -o TCPKeepAlive=yes -o ServerAliveInterval=10 -o ServerAliveCountMax=2 -CNR cartman.node.wfhack.com:9999:127.0.0.1:9999 wildfire@cartman.node.wfhack.com"
alias fbtunnel_clarketus="ssh -v -o TCPKeepAlive=yes -o ServerAliveInterval=10 -o ServerAliveCountMax=2 -CNR tunnel.clarketus.com:9999:127.0.0.1:9999 deploy@tunnel.clarketus.com"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# OSX specific
if [[ `uname` == 'Darwin' ]]; then
  PATH=/usr/local/sbin:/usr/local/bin:$PATH # Add sbin for homebrew

  bind "set completion-ignore-case on"
  bind "set show-all-if-ambiguous on"

  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
    complete -o default -F _git g
  fi
fi

