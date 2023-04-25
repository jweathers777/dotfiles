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

export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
. /opt/homebrew/opt/asdf/libexec/asdf.sh
. "$HOME/.cargo/env"
