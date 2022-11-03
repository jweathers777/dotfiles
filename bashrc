# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
   export PATH="$HOME/bin:$PATH"
fi

set -o vi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

# Define some color constants for use with our prompt
cancel="\[\e[m\]"
#bold="\[\e[1m\]"
#underline="\[\e[4m\]"
#blink="\[\e[5m\]"
#inverse="\[\e[7m\]"

black="\[\e[0;30m\]"
red="\[\e[0;31m\]"
green="\[\e[0;32m\]"
yellow="\[\e[0;33m\]"
blue="\[\e[0;34m\]"
magenta="\[\e[0;35m\]"
cyan="\[\e[0;36m\]"
light_gray="\[\e[0;37m\]"

default="\[\e[0;39m\]"

dark_gray="\[\e[1;30m\]"
bright_red="\[\e[1;31m\]"
bright_green="\[\e[1;32m\]"
bright_yellow="\[\e[1;33m\]"
bright_blue="\[\e[1;34m\]"
bright_magenta="\[\e[1;35m\]"
bright_cyan="\[\e[1;36m\]"
white="\[\e[1;37m\]"

account_color=$red
bright_account_color=$bright_red
path_color=$magenta

if [[ "$EUID" != "0" ]]; then
   account_color=$green
   bright_account_color=$bright_green
   path_color=$cyan
fi

function prompt_string { 
   printf "${dark_gray}(${account_color}\\\\u${bright_account_color}@${account_color}\h${dark_gray}:${path_color}\w${dark_gray})"
   if true; then
      printf ""
      git status 2>&1 | \
         if true; then
            is_git_repos=true
            while read -r line; do
               local c=$((c+1))
               if ((c == 1)); then
                  if [[ "$line" =~ ^'fatal: not a git repository' ]]; then
                     is_git_repos=false
                  else
                     if [[ "$line" =~ ^'# Not currently on any branch.' ]]; then
                        local branch='(none)'
                     else
                        local branch=$(echo $line | awk '{ print $3 }')
                     fi
                     local repo=${PWD##*/}
                     printf "\n${yellow}[${cyan}$repo${blue}:${cyan}$branch"
                  fi
               elif [[ "$line" =~ ^'Untracked files:' ]]; then
                  printf "${red}●"
               elif [[ "$line" =~ ^'Changes not staged for commit:' ]]; then
                  printf "${yellow}●"
               elif [[ "$line" =~ ^'Changes to be committed:' ]]; then
                  printf "${green}●"
               fi
            done
            if $is_git_repos; then
               printf "${yellow}]"
            fi
         fi
   fi
   printf "\n${path_color}\$${cancel} "
}

PROMPT_COMMAND=prompt_command
prompt_command() { 
   echo -ne "\\033]0;${PWD##*/}\\007"
   PS1=$(prompt_string) 
}

# Import local environment
[[ -s "$HOME/.aliases" ]] && . "$HOME/.aliases"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f "/Users/johnweathers/.ghcup/env" ] && source "/Users/johnweathers/.ghcup/env" # ghcup-env
. "$HOME/.cargo/env"
