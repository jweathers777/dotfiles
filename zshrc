export EDITOR=vim

export HISTFILE=~/.histfile
export HISTSIZE=1000000   # The number of items for the internal history list
export SAVEHIST=$HISTSIZE # The maximum number of items for the history file
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'

setopt SHAREHISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY_TIME
setopt EXTENDED_HISTORY
setopt CLOBBER

# 10ms for key sequences
KEYTIMEOUT=1

export PATH=/usr/local/bin:/usr/local/sbin:$PATH
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
   export PATH="$HOME/bin:$PATH"
fi

export NODE_PATH=/usr/local/lib/node_modules

bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
bindkey '^R' history-incremental-search-backward
#bindkey -M vi-command -x '",h":less ~/.vim/bash-vi-editing-mode-cheat-sheet.txt'
#bindkey -M vi-insert -x '"\C-h":less ~/.vim/bash-vi-editing-mode-cheat-sheet.txt'

autoload -Uz compinit
fpath+=~/.zfunc
compinit

# -----------------------------------------------
# Set up the prompt
# -----------------------------------------------
autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr '%F{green}●'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
zstyle ':vcs_info:*' enable git svn hg

precmd () {
   echo -ne "\\033]0;${PWD##*/}\\007"
   if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
      zstyle ':vcs_info:*' formats $'%F{yellow}[%F{cyan}%r%F{blue}:%F{cyan}%b%c%u%F{yellow}]\n'
   } else {
   zstyle ':vcs_info:*' formats $'%F{yellow}[%F{cyan}%r%F{blue}:%F{cyan}%b%c%u%F{red}●%F{yellow}]\n'
}

vcs_info
}
setopt prompt_subst
# normal user prompt
[ $UID != 0 ] && export PROMPT=$'%{\e[1;30m%}(%{\e[0;32m%}%F{green}%n%{\e[1;32m%}@%{\e[0;32m%}%F{green}%m%{\e[1;30m%}:%{\e[0;32m%}%F{cyan}%~%{\e[1;30m%})%{\e[0;32m%}\n${vcs_info_msg_0_}%F{cyan}%#%f '
# root prompt
[ $UID = 0 ] && export PROMPT=$'%{\e[1;30m%}(%{\e[0;32m%}%F{red}%n%{\e[1;31m%}@%{\e[0;31m%}%F{red}%m%{\e[1;30m%}:%{\e[0;32m%}%F{magenta}%~%{\e[1;30m%})%{\e[0;32m%}\n${vcs_info_msg_0_}%F{magenta}%#%f '

function zle-line-init zle-keymap-select {
   RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
   RPS2=$RPS1
   zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# -----------------------------------------------
# Set up completion for hostnames
# -----------------------------------------------

if [[ "$ZSH_VERSION_TYPE" == 'new' ]]; then
   : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}}
else
   # Older versions don't like the above cruft
   _etc_hosts=()
fi

hosts=(
"$_etc_hosts[@]"
#Add favourite hosts here, and zsh will autocomplete them
)

my_accounts=(
#Add favourite accounts here, and zsh will autocomplete them
)
# Import local favorite hosts and accounts
[[ -s "$HOME/.hosts" ]] && . "$HOME/.hosts"

zstyle ':completion:*' hosts $hosts
zstyle ':completion:*:my-accounts' users-hosts $my_accounts

# Fix issues with searching in vi-mode

vi-search-fix() {
   zle vi-cmd-mode
   zle .vi-history-search-backward
}
autoload vi-search-fix
zle -N vi-search-fix
bindkey -M viins '\e/' vi-search-fix

# Add more vim like behavior

bindkey "^?" backward-delete-char
bindkey "^W" backward-kill-word 
bindkey "^H" backward-delete-char      # Control-h also deletes the previous char
bindkey "^U" kill-line   

# -----------------------------------------------
#  User-defined Functions
# -----------------------------------------------

kill_all() { kill `ps -e|grep "$1"|grep -v 'grep'|awk '{print $1;}'` }

_rake_does_task_list_need_generating () {
   if [ ! -f .rake_tasks ]; then return 0;
   else
      accurate=$(stat -f%m .rake_tasks)
      changed=$(stat -f%m Rakefile)
      return $(expr $accurate '>=' $changed)
   fi
}

_rake () {
   if [ -f Rakefile ]; then
      if _rake_does_task_list_need_generating; then
         echo "\nGenerating .rake_tasks..." > /dev/stderr
         rake --silent --tasks | cut -d " " -f 2 > .rake_tasks
      fi
      compadd `cat .rake_tasks`
   fi
}

compdef _rake rake

# Import local environment
[[ -s "$HOME/.localenv" ]] && . "$HOME/.localenv"

# Import aliases
[[ -s "$HOME/.aliases" ]] && . "$HOME/.aliases"

# Import functions
[[ -s "$HOME/.functions" ]] && . "$HOME/.functions"

# -----------------------------------------------
#  END
# -----------------------------------------------


### Added by the Heroku Toolbelt
export PATH="$PATH:/usr/local/heroku/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$PATH:/User/johnweathers/perl5/bin"
PERL5LIB="/Users/johnweathers/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/johnweathers/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/johnweathers/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/johnweathers/perl5"; export PERL_MM_OPT;
