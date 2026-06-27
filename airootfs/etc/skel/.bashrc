# 5K default .bashrc
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -lah'
PS1='[\u@\h \W]\$ '

# Show the 5K fastfetch greeting on interactive login shells.
if [[ -z "$FIVEK_FASTFETCH_SHOWN" && -t 1 ]]; then
    export FIVEK_FASTFETCH_SHOWN=1
    command -v 5k-fastfetch >/dev/null 2>&1 && 5k-fastfetch
fi
