autoload -Uz compinit && compinit

function git_prompt {
    local statc="%F{230}" # assume clean
    local bname="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"

    if [ -n "$bname" ]; then
        local rs="$(git status --porcelain -b)"
        if $(echo "$rs" | grep -v '^##' &> /dev/null); then # is dirty
            statc="%F{166}"
        elif $(echo "$rs" | grep '^## .*diverged' &> /dev/null); then # has diverged
            statc="%F{206}"
        elif $(echo "$rs" | grep '^## .*behind' &> /dev/null); then # is behind
            statc="%F{226}"
        elif $(echo "$rs" | grep '^## .*ahead' &> /dev/null); then # is ahead
            statc="%F{86}"
        fi

        echo -n " $statc$bname%{\e[0m%} ❱"
    fi
}

# Set custom prompt
setopt prompt_subst
PROMPT='%F{153}%1~ ❱$(git_prompt)%f '

# Set default editor
export EDITOR='nvim'

# Set history behavior with up/down keys
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

# Aliases
alias e=nvim
alias r="tmux rename-session $argv"
alias g="git status -s -b $argv"
alias gg="git log --graph --decorate --all --date-order --pretty='%C(green)%h%C(reset) %C(italic blue)%ar%C(reset)%C(yellow)%d%C(reset) - %s' $argv"
alias bastion="tmux new-session -d -s bastion ./bastion.sh"

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

