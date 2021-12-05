export BASH_SILENCE_DEPRECATION_WARNING=1

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
[[ -s "$HOME/.bashrc" ]] && source "$HOME/.bashrc" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="$HOME/.cargo/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/johnweathers/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/johnweathers/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/johnweathers/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/johnweathers/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

[ -f "/Users/johnweathers/.ghcup/env" ] && source "/Users/johnweathers/.ghcup/env" # ghcup-env
