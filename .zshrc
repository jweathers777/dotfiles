HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=$HISTSIZE
setopt sharehistory
setopt hist_ignore_all_dups
setopt clobber

export PATH=/usr/local/bin:/usr/local/sbin:$PATH
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
   export PATH="$HOME/bin:$PATH"
fi

export NODE_PATH=/usr/local/lib/node_modules
export JAVA_HOME=$(/usr/libexec/java_home)

bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
bindkey '^R' history-incremental-search-backward
#bindkey -M vi-command -x '",h":less ~/.vim/bash-vi-editing-mode-cheat-sheet.txt'
#bindkey -M vi-insert -x '"\C-h":less ~/.vim/bash-vi-editing-mode-cheat-sheet.txt'

autoload -Uz compinit
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

# -----------------------------------------------
#  User-defined Functions
# -----------------------------------------------

kill_all() { kill `ps -e|grep "$1"|grep -v 'grep'|awk '{print $1;}'` }

install_git_bundle() {
   git submodule add $1 .vim/bundle/$2
   echo "   ignore = untracked" >> .gitmodules
   git add .
   git commit -m "Install $2 bundle as submodule"
}

install_vim_bundle() {
   mkdir -p ".vim/bundle/$2/$3"
   wget "$1" -O ".vim/bundle/$2/$3/$2.vim"
   git add .
   git commit -m "Install $2 bundle"
}

install_zipped_bundle() {
   mkdir ".vim/bundle/$2"
   wget "$1" -O ".vim/bundle/$2/$2.zip"
   cd ".vim/bundle/$2"
   unzip "$2.zip"
   cd ~
   rm ".vim/bundle/$2/$2.zip"
   git add .
   git commit -m "Install $2 bundle"
}

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

# Import local environment
[[ -s "$HOME/.aliases" ]] && . "$HOME/.aliases"

# Import rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && export rvm_prefix="$HOME/." && . "$HOME/.rvm/scripts/rvm"

__rvm_project_rvmrc

# -----------------------------------------------
#  END
# -----------------------------------------------

