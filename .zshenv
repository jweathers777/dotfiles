# Prepare common environment variables
export BLOCKSIZE=K
less --version 2>&1 >/dev/null && export PAGER=less
export EDITOR=vi
export GEMEDITOR=vim
export COLORTERM=yes
export GIT_EDITOR='vim --noplugin'
export SVN_EDITOR='vim --noplugin'
export CLICOLOR=1
export LSCOLORS=CxFxExDxBxegedabagacad

export POW_WORKERS=4
export JRUBY_OPTS="--1.9"


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
