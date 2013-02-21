source ~/.bash/aliases
source ~/.bash/completions
source ~/.bash/paths
source ~/.bash/config

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}
#export PS1="\[\033[1;33m\]\w\[\033[0m\]$ "
export PS1='\[\033[0;35m\]\u@\h\[\033[0;33m\] \w\[\033[00m\]$(__parse_git_branch): '
# export PS1='\h:\w\[\033[32m\]$(__git_ps1) \[\033[0m\]$ '
# use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
