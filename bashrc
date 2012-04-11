source ~/.bash/aliases
source ~/.bash/completions
source ~/.bash/paths
source ~/.bash/config

# use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi
export PS1="\[\033[0;35m\]\u@\h\[\033[0;33m\] \w\[\033[00m\]: "
